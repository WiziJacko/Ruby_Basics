class CargoCarriage < Carriage
  
  attr_accessor :all_volume
  attr_reader :occupied_volume

  DEFAULT_VOLUME = 100
  NOT_NUMERIC_CLASS_ERROR = "Название может быть только объектом класса String"

  def initialize
    @all_volume = DEFAULT_VOLUME
    @occupied_volume = 0
    super
  end

  def take_up_volume(value=10)
  	validate!(value)
    return if available_volume.nil?
    return @occupied_volume = @all_volume if available_volume < value
    @occupied_volume += value
  end

  def available_volume
    available_volume = @all_volume - @occupied_volume
    return if available_volume == 0
    available_volume
  end

  protected

  def validate!(value)
  	raise NOT_NUMERIC_CLASS_ERROR if !value.is_a?(Numeric)
  end
  
end
