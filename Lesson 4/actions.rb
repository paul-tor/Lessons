class Actions 

  def start #метод публичный - пользовательские действия
    loop do
      puts "\nВведите номер действия: \n1 - Создать станцию \n2 - Создать поезд \n3 - Создать маршрут \
            \n4 - Добавить, удалить станцию в маршруте \n5 - Назначить маршрут поезду \
            \n6 - Добавить вагон к поезду, отцепить вагон от поезда \
            \n7 - Переместить поезд по маршруту (вперед и назад) \n8 - Просмотреть список станций маршрута \
            \n9 - Посмотреть список поездов на  станции \nДля выхода - введите 'стоп'"
        
     user_input = gets.chomp

     case user_input
       when "1"
         self.create_station
       when "2"
         self.create_train
       when "3"
         self.create_route
       when "4"
         self.act_with_station
       when "5"
         self.set_route
       when "6"
         self.act_with_carriage
       when "7"
         self.act_with_train
       when "8"
         self.station_view
       when "9"
         self.train_view
      end
      break if user_input == "стоп"  
    end
  end

  protected #методы приватные - нужны только внутри класса

  def initialize
    @all_stations = []
    @all_trains = []
    @all_routes = []
  end

  def create_station
    puts "Введите название станции:"
    st_name = gets.chomp
    unless @all_stations.any?{ |station| station.name == st_name }
      st_obj = Station.new(st_name)
      @all_stations << st_obj
      puts "Станция создана"
    end
  end

  def create_train
    puts "Введите тип поезда (пасс/груз):"
    tr_type = gets.chomp
    puts "Введите номер поезда:"
    tr_numb = gets.chomp
    if tr_type == "пасс"
      unless @all_trains.any?{ |train| (train.type == "пасс") && (train.number == tr_numb) }
        tr_obj = PassengerTrain.new(tr_numb) 
        @all_trains << tr_obj
        puts "Пассажирский поезд создан"  
      end
    elsif tr_type == "груз"
      unless @all_trains.any?{ |train| (train.type == "груз") && (train.number == tr_numb) } 
        tr_obj = CargoTrain.new(tr_numb) 
        @all_trains << tr_obj
        puts "Грузовой поезд создан" 
      end
    else puts "Данные введены некорректно"
    end
  end

  def create_route
    puts "Введите начальную станцию маршрута:"
    first_st = gets.chomp
    puts "Введите конечную станцию маршрута:"
    last_st = gets.chomp
    route_imput = [first_st, last_st]
    arr_all_names = []      
    @all_stations.each_index { |index| arr_all_names << @all_stations[index].name }
    if route_imput.all?{ |name| arr_all_names.include?(name) } && @all_routes.all?{ |route| route.stations != route_imput }
      @all_stations.each_index do |index| 
        first_st = @all_stations[index] if @all_stations[index].name == route_imput[0]
        last_st = @all_stations[index] if @all_stations[index].name == route_imput[-1]
      end
      route_obj = Route.new(first_st, last_st)
      @all_routes << route_obj
      puts "Маршрут создан"
    else puts "Маршрут не создан - станций с таким именем не существует/данный маршрут уже есть" 
    end
  end

  def act_with_station
    puts "Kакой маршрут? Первая станция маршрута:"
    first_st = gets.chomp
    puts "Крайняя станция маршрута:"
    last_st = gets.chomp
    route_imput = [first_st, last_st]
    puts "Удалить/добавить станцию? (у/д):"
    act_imput = gets.chomp
    puts "Какую станцию? Название станции:"
    st_imput = gets.chomp 
    if (act_imput == "д") && (@all_stations.any?{ |station| station.name == st_imput })
    @all_stations.each do |station|
      st_imput = station if station.name == st_imput
    end             
      @all_routes.each do |route| 
        if (route.stations[0].name == route_imput[0]) && (route.stations[-1].name == route_imput[-1])
          route.inter(st_imput) 
          puts "Станция добавлена"
        end
      end
    elsif (act_imput == "у") && (@all_stations.any?{ |station| station.name == st_imput})
    @all_stations.each do |station|
      st_imput = station if station.name == st_imput
    end             
      @all_routes.each do |route| 
        if (route.stations[0].name == route_imput[0]) && (route.stations[-1].name == route_imput[-1])
          route.remove_inter(st_imput)
          puts "Станция удалена"
        end
      end
    else puts "Некорректный ввод данных"
    end
  end

  def set_route
    puts "Kакой поезд (пасс/груз)?:"
    train_type = gets.chomp
    puts "Номер поезда?:"
    train_numb = gets.chomp
    puts "Kакой маршрут? Первая станция маршрута:"
    first_st = gets.chomp
    puts "Крайняя станция маршрута:"
    last_st = gets.chomp         
    route_imput = [first_st, last_st]
    @all_trains.each do |train|
      if (train.type == "пасс") && (train.number == train_numb) && (train_type == "пасс")
        @all_routes.each do |route|
          if (route.stations[0].name == route_imput[0]) && (route.stations[-1].name == route_imput[-1])
            train.take_route(route) 
            puts "Маршрут для пассажирского поезда назначен"
          end
        end
      end
    end
    @all_trains.each do |train|  
      if (train.type == "груз") && (train.number == train_numb) && (train_type == "пасс")
        @all_routes.each do |route|
          if (route.stations[0].name == route_imput[0]) && (route.stations[-1].name == route_imput[-1])
            train.take_route(route) 
            puts "Маршрут для грузового поезда назначен"
          end
        end
      end
    end
  end

  def act_with_carriage
    puts "Kакой поезд (пасс/груз)?:"
    train_type = gets.chomp
    puts "Номер поезда?:"
    train_numb = gets.chomp     	
    puts "Удалить/добавить вагон? (у/д):"
    carr_imput = gets.chomp
    @all_trains.each do |train|    
      if ((carr_imput == "у") && (train_type == "пасс") && (train.type == "пасс") && (train.number == train_numb)) || \
         ((carr_imput == "у") && (train_type == "груз") && (train.type == "груз") && (train.number == train_numb))
        train.carr_break
        puts "Вагон отцеплен" 
      elsif (carr_imput == "д") 
          carriage = PassengerCarriage.new if (train_type == "пасс") && (train.type == "пасс") && (train.number == train_numb)
          carriage = CargoCarriage.new if (train_type == "груз") && (train.type == "груз") && (train.number == train_numb)
          train.carr_clutch(carriage) 
          puts "Вагон прицеплен"
      else puts "Данные введены некорректно"
      end
    end
  end

  def act_with_train
    puts "Kакой поезд (пасс/груз)?:"
    train_type = gets.chomp
    puts "Номер поезда?:"
    train_numb = gets.chomp
    puts "Переместить поезд вперёд или назад? (в/н):"
    train_act = gets.chomp
    @all_trains.each do |train|
      if (((train.current_station) && (train.number == train_numb) && (train_type == "пасс") && (train.type == "пасс")) || \
          ((train.current_station) && (train.number == train_numb) && (train_type == "груз") && (train.type == "груз"))) 
        if (train_act == "в")
          train.go_forward
          puts "Поезд перемещён вперёд"
        else (train_act == "н")
          train.go_back
          puts "Поезд перемещён назад"
        end
      else "Данные введены некорректно/Поезду не назначен маршрут"    
      end
    end
  end

  def station_view
    puts "Kакой маршрут? Первая станция маршрута:"
    first_st = gets.chomp
    puts "Крайняя станция маршрута:"
    last_st = gets.chomp
    route_imput = [first_st, last_st]
    @all_routes.each do |route|
      puts route.stations.to_s if (route.stations[0].name == route_imput[0]) && (route.stations[-1].name == route_imput[-1])
    end
  end

  def train_view
    puts "Введите название станции:"
    st_name = gets.chomp
    @all_stations.each do |station| 
      puts station.trains.to_s if station.name == st_name
    end
  end

end
