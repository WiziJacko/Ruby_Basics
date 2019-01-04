require_relative 'company'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Train
  include Company
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :speed, :carriages, :type, :route
  strong_attr_accessor :number, String

  NUMBER_FORMAT = /^[а-яё\d]{3}-?[а-яё\d]{2}$/i.freeze
  TRAIN_EXISTS_ERROR = 'Поезд с таким номером уже существует'.freeze
  FORMAT_ERROR = 'Номер не соответствует формату'.freeze

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
    return if !@speed.zero? || carriage.attached? || @carriages.include?(carriage)

    @carriages << carriage
    carriage.attach!
  end

  def unhook_carriage(carriage)
    if @speed.zero? && !@carriages.empty? && carriage.attached?
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

    @route.stations[@current_station - 1] if @current_station != 0
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

end
