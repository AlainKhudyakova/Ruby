class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @@stations ||= []

  def self.all
    @@stations.each_with_index {|val, index| puts "#{index + 1}. #{val.name}" }
  end

  def self.find(name)
    @@stations.find {|t| t.name == name}
  end

  def initialize(name)
    @name = name.to_s.capitalize
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

  def each_train(&block)
    @trains.each { |t| block.call(t) }
  end

  def each_train_with_index(&block)
    @trains.each_train_with_index { |t, i| block.call(t, i) }
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
