class CargoTrain < Train

  def initialize(number, type = :cargo)
    super
  end

  def hook_carriage(carriage)
    return if carriage.type != :cargo
    super
  end

  def unhook_carriage(carriage)
    return if carriage.type != :cargo
    super
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(CargoCarriage)
  end

end
