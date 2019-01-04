class PassengerCarriage < Carriage
  DEFAULT_PLACES = 10
  ZERO_ERROR = 'Все места заняты'.freeze

  def initialize(space = DEFAULT_PLACES)
    super
  end

  def take_up_space
    raise ZERO_ERROR if available_spaces.zero?

    @occupied_spaces += 1
  end
end
