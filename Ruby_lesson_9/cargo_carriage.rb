class CargoCarriage < Carriage
  DEFAULT_VOLUME = 100
  ZERO_ERROR = 'Весь объем занят'.freeze
  OVER_SPACE_ERROR = 'Невозможно заполнить такой объем, выберите меньшее значение'.freeze

  def initialize(space = DEFAULT_VOLUME)
    super
  end
end
