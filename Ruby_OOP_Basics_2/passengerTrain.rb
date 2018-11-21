class PassengerTrain < Train

  def initialize(number, type = :passenger)
    super
  end

  def hook_carriage(carriage)
  	return if carriage.type != :passenger
  	super
  end

  def unhook_carriage(carriage)
    return if carriage.type != :passenger
    super
  end

end
