class Station
   attr_reader :name, :trains

   def initialize(name)
      @name = name
      @trains = []
   end

   def arrive(train)
      @trains << train
   end

   def return_type(type)
      @trains.delete(train)
   end

   def show_trains_by_type(type)
      @trains.select{|train| train.type == type}
      puts "#{@trains}"
   end

end


class Route
   attr_reader :route, :stations

   def initialize(initial_point, final_point)
      @initial_point = initial_point
      @final_point = final_point
      @stations = [initial_point, final_point]
   end

   def add_station(station)
      @stations.inspect(-2, station)
   end

   def delete_station(station)
      @station.delete(station)
   end

   def show_stations
      @stations
   end

end

class Train
   attr_reader :number, :type

   def initialize(number, type)
      @number = number
      @type = type
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

   def add_wagons
      @wagons = 0
      @wagons - @wagons + 1 if @speed == 0
   end

   def del_wagons
      @wagons -= 1 if @wagons >= 0 || @speed == 0
   end

   def show_wagons
      @wagons
   end

   def s_route(route)
      @route = route
      @current_station_index = 0
   end

   def show_train_route
      @route.stations
   end

   def move_forward
      @current_station_index += 1 if next_station
   end

   def move_back
      @current_station_index -= 1 if previous_station
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

   def location
      puts"previous: #{@route.stations[@current_station_index - 1]}"
      puts"current: #{@route.stations[@current_station_index]}"
      puts"next: #{@route.stations[@current_station_index + 1]}"
   end

end

station1 = Station.new("Ufa")
station2 = Station.new("Saratov")
station3 = Station.new("Samara")
station4 = Station.new("Sochi")

train1 = Train.new("002", "cargo")
train2 = Train.new("0112", "passanger")
train3 = Train.new("003", "cargo")
train4 = Train.new("0113", "passanger")

station1.arrive(train1)
station1.arrive(train2)
station1.arrive(train3)
station1.arrive(train4)
station1.show_trains_by_type("cargo")
station1.show_trains_by_type("passanger")

route1 = Route.new("Ufa", "Soshi")
route2 = Route.new("Sochi", "Ufa")
route3 = Route.new("Ufa", "Samara")
route4 = Route.new("Samara", "Ufa")






