class CargoTrain < Train
 
  def carr_clutch(carriage) #public: По заданию, пользователь моежт прицеплять вагоны
    super if carriage.class == CargoCarriage
  end

end
