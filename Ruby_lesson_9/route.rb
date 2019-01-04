require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations, :name

  SAME_STATIONS_ERROR = 'Станция отправления и станция прибытия не могут быть одинаковыми'.freeze
  NOT_STATION_CLASS_ERROR = 'Некорректный класс передаваемых параметров'.freeze

  def initialize(station_of_departure, station_of_arrival)
    @station_of_departure = station_of_departure
    @station_of_arrival = station_of_arrival
    @name = "#{station_of_departure.name} -> #{station_of_arrival.name}"
    validate!
    @stations = [station_of_departure, station_of_arrival]
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_station(station)
    return if @stations.include?(station)

    @stations.insert(-2, station)
  end

  def delete_station(station)
    if station != @stations[0] && station != @stations[-1]
      @stations.delete(station)
    end
  end

  def show_stations
    puts 'Список станций маршрута:'
    puts '--------------'
    @stations.each { |station| puts station.name }
    puts '--------------'
  end

  def to_s
    name
  end

  protected

  def validate!
    raise NOT_STATION_CLASS_ERROR if !@station_of_departure.is_a?(Station) || !@station_of_arrival.is_a?(Station)
    raise SAME_STATIONS_ERROR if @station_of_departure == @station_of_arrival
  end
end
