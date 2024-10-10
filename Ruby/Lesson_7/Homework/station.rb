class Station
  include InstanceCounter
  include Validation

  attr_reader :name

  @@stations = []

  def self.all
    @@stations.each_with_index { |val, index| puts "#{index + 1}. #{val.name}" }
  end


  def initialize(name)
    @name = name.to_s.capitalize
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def train_arrival(train)
    @trains << train 
  end

  def departure(train)
    @trains.delete(train) 
  end

  def display_trains_on_station
    @trains.each_with_index do |train, index|
      puts "#{index + 1}. train: number - #{train.number}; type - #{train.type}"
    end
  end

  def all_trains(&block)
    @trains.each(&block)
  end

protected

  def validate!
    raise "Station name cannot be blank" if name.nil?
    raise "Station name must be between 2 and 50 characters long" if invalid_length?(name)
  end
end
