class Train
  include InstanceCounter
  include Company
  include Validation
  attr_reader :number, :type, :wagons, :stations, :route

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    @@trains << self
    register_instance
  end

  PASSENGER_TYPE = :passenger
  CARGO_TYPE = :cargo

  @@trains = []

  def validate! 
    raise ArgumentError, 'Number of train must be between 3 characters long' unless number.length > 3
    raise ArgumentError, 'Number has invalid format' unless number =~ NUMBER_FORMAT

    true
  end

  def self.find(number)
    @@trains.each_with_index { |train, index| puts "#{index + 1}. #{train}" if train.number == number }
  end

  def start
    @speed = 15
  end

  def speed_up
    @speed += 15
  end

  def current_speed
    @speed
  end

  def speed_down
    @speed -= 15 if @speed > 0
  end

  def stop
    @speed = 0
  end

  def add_wagons(wagon)
    @wagons << wagon if @speed.zero? && wagon.type == type
  end

  def delete_wagons
    @wagons.pop
  end

  def show_wagons
    puts "The #{type} train number: #{number} has #{@wagons.length} wagon(s)"
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    @current_station = @route.stations[@current_station_index] if @route
  end

  def show_train_route
    puts 'Train route:'
    @route.stations.each_with_index { |station, index| print "#{index + 1} - #{station.name}; " }
    puts ''
  end

  def move_forward
    @current_station_index += 1 if next_station
  end

  def move_back
    @current_station_index -= 1 if previous_station
  end

  def show_current_station
    puts "Current station: #{@route.stations[@current_station_index].name}"
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end

  def all_wagons(&block)
    @wagons.each(&block)
  end
end
