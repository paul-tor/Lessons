class Station
  
  attr_reader :name, :trains  
  
  def initialize(name) 
    @name = name
    @trains = []
  end
  
  def take_train(train)
   @trains << train
  end

  def train_type(train_type)
    count = 0
    trains.each do |train|  
      count += 1 if train.type == train_type
    end
    count 
  end
  
  def send_train(train)
    @trains.delete(train)
  end
end

class Route

  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def inter(inter_station)       
    @stations.insert(-2, inter_station)
  end

  def remove_inter(inter_station)   
    @stations.delete(inter_station)
  end
end

class Train

  attr_reader :carr_count,:type, :tr_numb, :speed
   
  def initialize(tr_numb, type, carr_count) 
    @tr_numb = tr_numb
    @type = type
    @carr_count = carr_count
    @speed = 0
  end

  def add_speed(add_speed)
    @speed += add_speed
  end

  def stop              
    @speed = 0
  end

  def carr_clutch      
    @carr_count += 1 if self.speed == 0
  end
  
  def carr_break        
    if self.speed == 0 && @carr_count != 0
      @carr_count -= 1
    else  @carr_count
    end
  end

  def take_route(route)
    @route = route
    @station_index = 0                     
    self.current_station.take_train(self)
  end

  def current_station
    @route.stations[@station_index]
  end

  def go_forward 
    if self.current_station != @route.stations.last  
      self.current_station.send_train(self)
      @station_index += 1
      self.current_station.take_train(self)
    end
  end

  def go_back
    if self.current_station != @route.stations.first
      self.current_station.send_train(self)
      @station_index -= 1
      self.current_station.take_train(self)
    end
  end

  def next_station
    if (@station_index + 1) < @route.stations.size
      @route.stations[@station_index + 1]
    else 
      @route.stations.last
    end
  end 

  def prev_station
    if @station_index != 0
      @route.stations[@station_index - 1]
    else 
      @route.stations[0]
    end
  end
end
