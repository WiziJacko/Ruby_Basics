require_relative 'instance_counter'

class Station

  include InstanceCounter

  attr_reader :name, :trains

  NOT_ZERO_LENGTH_NAME_ERROR = "Название не может быть пустым"
  STATION_EXISTS_ERROR = "Такая станция уже существует"
  NOT_STRING_CLASS_ERROR = "Название может быть только объектом класса String"

  @@instances = {}

  class << self
    def all
      @@instances.values
    end

    def find(name)
      @@instances[name]
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@instances[name] = self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def train_in(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def train_out(train)
    @trains.delete(train)
  end

  def to_s
    name
  end

  def each_train(&block)
    trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise NOT_STRING_CLASS_ERROR if !@name.is_a?(String)
    raise NOT_ZERO_LENGTH_NAME_ERROR if @name.length == 0
    raise STATION_EXISTS_ERROR if Station.find(@name)
  end

end
