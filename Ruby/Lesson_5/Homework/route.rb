class Route
  include InstanceCounter
  attr_reader :stations, :initial_point, :final_point

 def initialize(initial_point, final_point)
   @initial_point = initial_point
   @final_point = final_point
   @stations = [initial_point, final_point]
 end

 def add_station(station)
   @stations.insert(-2, station) unless station_included?(station)
 end

 def delete_station_route(station)
   return "The start and end stations cannot be delete" if not_start_and_end?(station)
   @stations.delete(station) if station_included?(station)
 end

 def show_route_stations
   puts "This route consists of #{@stations.length} station(s): "
   @stations.each_with_index {|station, index| print "#{index + 1} - #{station.name};" }
   puts " "
 end

private 

#метод проверяет есть ли станция в текущем маршруте, внесет в private т.к. 
#метод не должен быть доступен для вызова вне класса и должен вызываться только внутри методов add_station и delete_station_route

 def station_included?(station)
   @stations.include?(station)
 end

#метод проверяет является ли станция начальной или конечно и не должен быть доступен для вызова вне класса
#должен вызываться только внутри метода delete_station_route


 def not_start_and_end?(station)
   station == @stations[0] || station == @stations[-1]
 end
end