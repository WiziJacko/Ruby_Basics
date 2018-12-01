require_relative 'instance_counter'

class Station

  include InstanceCounter

  attr_reader :name, :trains

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

  protected

  def validate!
    raise "Название не может быть пустым" if @name.length == 0
    raise "Такая станция уже существует" if Station.find(@name)
  end

end
