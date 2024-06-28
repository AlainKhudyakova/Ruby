class Route
 attr_reader :route, :stations

 def initialize(initial_point, final_point)
    @initial_point = initial_point
    @final_point = final_point
    @stations = [initial_point, final_point]
 end

 def add_station(station)
    @stations.insert(-2, station)
 end

 def delete_station_route(station)
    @stations.delete(station)
 end

 def show_route_stations
    puts "This route consists of #{@stations.length} station(s): "
    @stations.each_with_index {|station, index| print "#{index + 1} - #{station.name};" }
    puts " "
 end

end