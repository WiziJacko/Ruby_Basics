class PassengerCarriage < Carriage

  attr_accessor :all_places
  attr_reader :occupied_places

  DEFAULT_PLACES = 10

  def initialize
    @all_places = DEFAULT_PLACES
    @occupied_places = 0
    super
  end
  
  def take_place
    return if available_places.zero?
    @occupied_places += 1
  end

  def available_places
    available_places = @all_places - @occupied_places
  end
  
end
