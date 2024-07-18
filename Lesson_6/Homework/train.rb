class Train
  include InstanceCounter
  include Company
  include Validation

  @@trains ||= []

  def self.all
    @@trains
  end


  def self.find(number)
    @@trains.find { |t| t.number = number }
  end

  PASSENGER_TYPE = :passanger
  CARGO_TYPE = :cargo


  NUMBER_FORMAT = /^[a-za-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  attr_reader :number, :type, :wagons


  @@trains = []

  def initialize(number)
    @number = number
    @type = nill 
    @speed = 0
    @wagons = []
    @@trains << self
    validate!
    register_instance
  end


  def start
    @speed = 15
  end

  def spped up
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
    @wagons = 0
    @wagons - @wagons + 1 if @speed == 0
  end

  def delete_wagons
    @wagons -= 1 if @wagons >= 0 || @speed == 0
  end

  def show_wagons
    puts "The #{type} train number: #{number} has wagon(s)"
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
  end

  def show_train_route
    puts "Train route:"
      @route.station.each_with_index {|station, index| print "#{index + 1} - #{station.name}; "}
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

protected

  def validate!
    raise NotImplementedError, "Unable to create an object of a Class that is a parent!" if instance_of?(Train)
    raise "Number of train cannot be blank" if number.nil?
    raise "Number of train must be between 5 and 6 characters long" if invalid_length?(number, 5, 6)
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
    raise "Company name must be between 4 and 30 characters long" if !company_name.nil? && invalid_length?(company_name)
  end
end