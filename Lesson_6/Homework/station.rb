class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @@stations ||= []

  def self.all
    @@stations
  end

  def self.find(name)
    @@stations.find {|t| t.name == name}
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def train_arrival(train)
    @trains << train unless train_include?(train)
  end

  def departure(train)
    @trains.delete(train) if train_include?(train)
  end

  def trains_type(type)
    @trains.filter { |t| t.type == type }.size
  end

protected

  def validate!
    raise "Station name cannot be blank" if name.nil?
    raise "Station name must be between 4 and 30 characters long" if invalid_length?(name)
  end

private

  def train_include?(train)
    @train.include?(train)
  end
end
