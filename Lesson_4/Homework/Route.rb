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
    puts "This route consists of #{@stations.lenght} station(s): "
    @stations.each_with_index {|station, index| print "#{index + 1} - #{station.name}; " }
    puts " "
 end

end