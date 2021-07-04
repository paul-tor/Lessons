class Train

  attr_reader :number, :type
    
  def initialize(number,type) 
    @number = number
    @carriages = []
    @speed = 0
    @type = type
  end

  def carr_break #public: По заданию, пользователь может отцеплять вагоны
    @carriages.delete_at(-1) if self.speed == 0 && self.carr_count != 0
  end

  def carr_clutch(carriage) #public: По заданию, пользователь может прицеплять вагоны     
    @carriages << carriage if self.speed == 0
  end

  def take_route(route) #public: По заданию, пользователь может назначать маршрут поезду
    @route = route
    @station_index = 0                     
    self.current_station.take_train(self)
  end

  def go_forward  #public: По заданию, пользователь может перемещать поезда вперёд
    return unless self.next_station  
    self.current_station.send_train(self)
    @station_index += 1
    self.current_station.take_train(self)
  end

  def go_back #public: По заданию, пользователь может перемещать поезда назад
    return unless self.current_station != @route.stations.first
    self.current_station.send_train(self)
    @station_index -= 1
    self.current_station.take_train(self)
  end

  def current_station #public: необходим для перемещения поезда пользоателем
    @route.stations[@station_index]
  end  

  protected 
  
  attr_reader :speed #protected: видимость внутри класса и подклассах. По заданию, пользователь не может узнавать скорость

  def carr_count #protected: видимость внутри класса и подклассах. По заданию, пользователь не может узнавать кол-во вагонов
    @carr_count = @carriages.size
  end

  def add_speed(add_speed) #protected: видимость внутри класса и подклассах. По заданию, пользователь не может увеличивать скорость
    @speed += add_speed
  end

  def stop #protected: видимость внутри класса и подклассах. По заданию, пользователь не может останавливать поезд          
    @speed = 0
  end

  def next_station #protected: видимость внутри класса и подклассах. По заданию, пользователь не может узнавать следующую станцию. 
    @route.stations[@station_index + 1] if (@station_index + 1) < @route.stations.size
  end 

  def prev_station #protected: видимость внутри класса и подклассах. По заданию, пользователь не может узнавать предыдущую станцию.
    if @station_index != 0
      @route.stations[@station_index - 1]
    else 
      @route.stations[0]
    end
  end
end
