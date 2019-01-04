class PassengerTrain < Train

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :number, :type, String

  def initialize(number, type = :passenger)
    super
  end

  def attachable_carriage?(carriage)
    carriage.is_a?(PassengerCarriage)
  end
end
