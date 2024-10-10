class Train
 attr_reader :number, :type, :wagons

 def initialize(number)
  @number = number
  @speed = 0
  @wagons = []
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

 def add_wagons(wagon)
  @wagons = 0
  @wagons - @wagons + 1 if @speed == 0
 end

 def delete_wagons
  @wagons -= 1 if @wagons >= 0 || @speed == 0
 end

 def show_wagons
  puts "The #{self.type} train number: #{self.number} has wagon(s)"
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
end
