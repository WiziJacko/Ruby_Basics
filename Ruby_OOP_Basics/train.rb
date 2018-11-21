class Train

  attr_reader :speed, :carriages, :number, :type, :route

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages
    @speed = 0
  end

  def speed_up(value)
    @speed += value
  end

  def speed_down(value)
    if @speed - value < 0 
      @speed = 0
    else
      @speed -= value
    end
  end

  def hook_carriage
    if @speed == 0
      @carriages += 1
    end
  end

  def unhook_carriage
    if @speed == 0 && @carriages > 0
      @carriages -= 1
    end
  end

  def get_route(route)
    @route = route
    @current_station = 0
    @route.stations[0].train_in(self)
  end

  def current_station
    return if @route.nil?
    @route.stations[@current_station]
  end

  def previous_station
    return if @route.nil?
    if @current_station != 0
      @route.stations[@current_station - 1]
    end
  end

  def next_station
    return if @route.nil?
    @route.stations[@current_station + 1]
  end

  def go_next_station
    return if next_station.nil?
    current_station.train_out(self)
    next_station.train_in(self)
    @current_station += 1
  end

  def go_previous_station
    return if previous_station.nil?
    current_station.train_out(self)
    previous_station.train_in(self)
    @current_station -= 1
  end

end
