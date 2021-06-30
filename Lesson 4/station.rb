class Station
  
  attr_reader :name, :trains  #public: Пользователю можно просматривать список поездов на станции. Пользователю нужно будет узнавать имя станции, чтобы можно было просматривать список поездов на станции
  
  def initialize(name) 
    @name = name
    @trains = []
  end

  def take_train(train) #public: Методы должны быть видны в классе Train
   @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end
end
