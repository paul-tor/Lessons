require_relative "station"
require_relative "route"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "passenger_carriage"
require_relative "cargo_carriage"

all_stations = []
all_passenger_trains = []
all_cargo_trains = []
all_routes = []

loop do
  puts "\nВведите номер действия: \n1 - Создать станцию \n2 - Создать поезд \n3 - Создать маршрут \
        \n4 - Добавить, удалить станцию в маршруте \n5 - Назначить маршрут поезду \
        \n6 - Добавить вагон к поезду, отцепить вагон от поезда \
        \n7 - Переместить поезд по маршруту (вперед и назад) \n8 - Просмотреть список станций маршрута \
        \n9 - Посмотреть список поездов на  станции \nДля выхода - введите 'стоп'"
        
  user_input = gets.chomp

  case user_input
    when "1"
      puts "Введите название станции:"
      st_name = gets.chomp
      unless all_stations.any?{ |station| station.name == st_name }
        st_obj = Station.new(st_name)
        all_stations << st_obj
        puts "Станция создана"
      end

    when "2"
      puts "Введите тип поезда (пасс/груз):"
      tr_type = gets.chomp
      puts "Введите номер поезда:"
      number = gets.chomp
      if tr_type == "пасс"
        unless all_passenger_trains.any?{ |passenger_train| passenger_train.number == number }        
          tr_obj = PassengerTrain.new(number) 
          all_passenger_trains << tr_obj
          puts "Пассажирский поезд создан"  
        end
      elsif tr_type == "груз"
        unless all_cargo_trains.any?{ |cargo_train| cargo_train.number == number }        
          tr_obj = CargoTrain.new(number) 
          all_cargo_trains << tr_obj
          puts "Грузовой поезд создан" 
        end
      else puts "Данные введены некорректно"
      end

    when "3"
      puts "Введите начальную станцию маршрута:"
      first_st = gets.chomp
      puts "Введите конечную станцию маршрута:"
      last_st = gets.chomp
      route_imput = [first_st, last_st]
      arr_all_names = []      
      all_stations.each_index { |index| arr_all_names << all_stations[index].name }
      if route_imput.all?{ |name| arr_all_names.include?(name) } && all_routes.all?{ |route| route.stations != route_imput }
        all_stations.each_index do |index| 
          first_st = all_stations[index] if all_stations[index].name == route_imput[0]
          last_st = all_stations[index] if all_stations[index].name == route_imput[-1]
        end
        route_obj = Route.new(first_st, last_st)
        all_routes << route_obj
        puts "Маршрут создан"
      else puts "Маршрут не создан - станций с таким именем не существует/данный маршрут уже есть" 
      end

    when "4"
      puts "Kакой маршрут? Первая станция маршрута:"
      first_st = gets.chomp
      puts "Крайняя станция маршрута:"
      last_st = gets.chomp
      route_imput = [first_st, last_st]
      all_routes.each do |route| 
        if (route.stations[0].name == route_imput[0]) && (route.stations[-1].name == route_imput[-1])
          puts "Удалить/добавить станцию? (у/д):"
          act_imput = gets.chomp
          puts "Какую станцию? Название станции:"
          st_imput = gets.chomp 
          if (act_imput == "д") && (all_stations.any?{ |station| station.name == st_imput })
            all_stations.each do |station|
              st_imput = station if station.name == st_imput
            end            
            route.inter(st_imput)
            puts "Станция добавлена"
          elsif (act_imput == "у") && (route.stations.any?{ |station| station.name == st_imput})
            route.stations.each do |station|
              st_imput = station if station.name == st_imput
            end            
            route.remove_inter(st_imput)
            puts "Станция удалена"
          else puts "Станции с введённым именем не существует/Станция не включена в маршрут"
          end
        else puts "Маршрут введён некорректно"         
        end
      end

    when "5"       
      puts "Kакой поезд (пасс/груз)?:"
      train_type = gets.chomp
      puts "Номер поезда?:"
      train_numb = gets.chomp
      puts "Kакой маршрут? Первая станция маршрута:"
      first_st = gets.chomp
      puts "Крайняя станция маршрута:"
      last_st = gets.chomp         
      route_imput = [first_st, last_st]
      all_routes.each do |route|
        if (route.stations[0].name == route_imput[0]) && (route.stations[-1].name == route_imput[-1])
          all_passenger_trains.each do |passenger_train|
            passenger_train.take_route(route) if (passenger_train.number == train_numb && train_type == "пасс")
          end
          all_cargo_trains.each do |cargo_train|
            cargo_train.take_route(route) if (cargo_train.number == train_numb && train_type == "груз")
          end
          puts "Маршрут назначен"
        else puts "Данные введены некорректно"
        end
      end

    when "6"
      puts "Kакой поезд (пасс/груз)?:"
      train_type = gets.chomp
      puts "Номер поезда?:"
      train_numb = gets.chomp     	
      puts "Удалить/добавить вагон? (у/д):"
      carr_imput = gets.chomp
      if train_type == "пасс" 
        all_passenger_trains.each do |passenger_train|
          if carr_imput == "у" && passenger_train.number == train_numb
            passenger_train.carr_break
            puts "Вагон отцеплен" 
          end
          if carr_imput == "д" && passenger_train.number == train_numb
            pass_carriage = PassengerCarriage.new
            passenger_train.carr_clutch(pass_carriage) 
            puts "Вагон прицеплен"
          end
        end
      elsif train_type == "груз"
        all_cargo_trains.each do |cargo_train|
          if carr_imput == "у" && cargo_train.number == train_numb
            cargo_train.carr_break 
            puts "Вагон отцеплен"
          end
          if carr_imput == "д" && cargo_train.number == train_numb
            cargo_carriage = CargoCarriage.new
            cargo_train.carr_clutch(pass_carriage)
            puts "Вагон прицеплен"
          end
        end 
      else puts "Данные введены некорректно"
      end

    when "7"
      puts "Kакой поезд (пасс/груз)?:"
      train_type = gets.chomp
      puts "Номер поезда?:"
      train_numb = gets.chomp
      puts "Переместить поезд вперёд или назад? (в/н):"
      train_act = gets.chomp
      if train_type == "пасс" 
        all_passenger_trains.each do |passenger_train|
          if train_act == "в" && passenger_train.number == train_numb && passenger_train.current_station
            passenger_train.go_forward
            puts "Поезд перемещён вперёд" 
          end
          if train_act == "н" && passenger_train.number == train_numb && passenger_train.current_station
            passenger_train.go_back
            puts "Поезд перемещён назад"
          end
        end
      elsif train_type == "груз" 
        all_cargo_trains.each do |cargo_train|
          if train_act == "в" && cargo_train.number == train_numb && cargo_train.current_station
            cargo_train.go_forward
            puts "Поезд перемещён вперёд" 
          end
          if train_act == "н" && cargo_train.number == train_numb && cargo_train.current_station
            cargo_train.go_back
            puts "Поезд перемещён назад"
          end
        end            
      else "Данные введены некорректно/Поезду не назначен маршрут"    
      end
 
    when "8"
      puts "Kакой маршрут? Первая станция маршрута:"
      first_st = gets.chomp
      puts "Крайняя станция маршрута:"
      last_st = gets.chomp
      route_imput = [first_st, last_st]
      all_routes.each do |route|
        puts route.stations.to_s if (route.stations[0].name == route_imput[0]) && (route.stations[-1].name == route_imput[-1])
      end

    when "9"      
      puts "Введите название станции:"
      st_name = gets.chomp
      all_stations.each do |station| 
        puts station.trains.to_s if station.name == st_name
      end

  end
  break if user_input == "стоп"  
end




