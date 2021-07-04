class PassengerTrain < Train

  def initialize(number, type = "пасс") 
    super
  end

  def carr_clutch(carriage) #public: По заданию, пользователь моежт прицеплять вагоны
    super if carriage.class == PassengerCarriage
  end
  
end
