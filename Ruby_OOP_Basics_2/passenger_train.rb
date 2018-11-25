class PassengerTrain < Train

  def initialize(number, type = :passenger)
    super
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end

end
