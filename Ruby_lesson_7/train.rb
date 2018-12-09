require_relative 'company'
require_relative 'instance_counter'

class Train

  include Company
  include InstanceCounter

  attr_reader :speed, :carriages, :number, :type, :route

  NUMBER_FORMAT = /^[а-яё\d]{3}-?[а-яё\d]{2}$/i
  TRAIN_EXISTS_ERROR = "Поезд с таким номером уже существует"
  FORMAT_ERROR = "Номер не соответствует формату"

  @@instances = {}
  
  class << self
    def all
      @@instances.values
    end

    def find(number)
      @@instances[number]
    end
  end

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @carriages = []
    validate!
    @@instances[number] = self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
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

  def hook_carriage(carriage)
    return unless attachable_carriage?(carriage)
    return if @speed != 0 || carriage.attached? || @carriages.include?(carriage)
    @carriages << carriage
    carriage.attach!
  end

  def unhook_carriage(carriage)
    if @speed == 0 && @carriages.size > 0 && carriage.attached?
      @carriages.delete(carriage)
      carriage.detach!
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

  def to_s
    number
  end

  def each_carriage
    carriages.each { |carriage| yield(carriage) }
  end

  protected

  def validate!
    raise FORMAT_ERROR if @number !~ NUMBER_FORMAT
    raise TRAIN_EXISTS_ERROR if Train.find(@number)
  end

end
