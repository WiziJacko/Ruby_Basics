require_relative 'instance_counter'

class Station

  include InstanceCounter

  attr_reader :name, :trains

  @@instances = {}

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    @@instances[name] = self
    register_instance
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

end
