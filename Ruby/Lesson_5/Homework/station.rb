class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@stations ||= []

 def self.all
   @@stations
 end

 def initialize(name)
   @name = name
   @trains = []
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

private

 def train_include?(train)
   @train.include?(train)
 end
end
