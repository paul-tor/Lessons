class Route # все методы публичные: пользователь может просматривать список станций маршрута и добавлять/удалять станции в нём 

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
