class CargoCarriage < Carriage
  
  attr_accessor :all_volume
  attr_reader :occupied_volume

  DEFAULT_VOLUME = 100.0

  def initialize
    @all_volume = DEFAULT_VOLUME
    @occupied_volume = 0.0
    super
  end

  def take_up_volume(value=10)
    return if available_volume.zero?
    return @occupied_volume = @all_volume if available_volume < value
    @occupied_volume += value
  end

  def available_volume
    available_volume = @all_volume - @occupied_volume
  end
end
