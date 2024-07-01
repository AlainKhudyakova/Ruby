class Station
 attr_reader :name, :trains

def initialize(name)
  @name = name
  @trains = []
end

def train_arrival(train)
  @trains << train
end

def departure(train)
  @trains.delete(train)
end

def show_trains_on_station
  @trains.each_with_index {|train, index| puts "#{index + 1}. train: number - #{train.number}; type - #{train.type}"}
end
end
