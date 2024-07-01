require_relative "Main"
require_relative "Route"
require_relative "Station"
require_relative "Train"
require_relative "Train_cargo"
require_relative "Train_passanger"
require_relative "Wagon"
require_relative "Wagon_cargo"
require_relative "Wagon_passanger"


rr = RailRoad.new
  @stations = []
  @trains = []
  @routes = []
  @wagons = []

puts "1. Create station "
  @stations << Station.new("Sochi")
  @stations << Station.new("Moscow")
  @stations << Station.new("Kazan")
  @stations << Station.new("Ufa")
  @stations << Station.new("Irkutsk")
  @stations << Station.new("Saint-Petersburg")
  @stations << Station.new("Omsk")
  @stations.each_with_index {|val, index| puts "#{index + 1}. #{val.name}" }
puts ""

puts "2. Create train"
  @trains << TrainPassanger.new("01P")
  @trains << TrainPassanger.new("02P")
  @trains << TrainCargo.new("03C")
  @trains << TrainCargo.new("04C")
  @trains.each_with_index {|val, index| puts "#{index + 1}. #{val.number} - #{val.type}" }
puts ""


puts "3. Create route"
  @routes << Route.new(@stations[0], @stations[-1])
  @routes.each_with_index {|val, index| puts "#{index + 1}. #{val.stations[0].name} - #{val.stations[-1].name}" }
puts ""

puts "4. Create wagon"
  @wagons << WagonCargo.new
  @wagons << WagonPassanger.new
  @wagons.each_with_index {|wagon, index| puts "#{index + 1}.#{wagon.type}"}
puts ""

puts "5. Add route a station"
  @routes[0].add_station(@stations[1])
  @routes[0].add_station(@stations[2])
  @routes[0].add_station(@stations[3])
  @routes[0].add_station(@stations[4])
  @routes[0].add_station(@stations[5])
  @routes[0].show_route_stations
puts ""

puts "6. Delete route a station"
  @routes[0].delete_station_route(@stations[5])
  @routes[0].show_route_stations
puts ""

puts "7. Adding train route"
  @trains[0].set_route(@routes[0])
  @trains[1].set_route(@routes[0])
  @trains[2].set_route(@routes[0])
  @trains[3].set_route(@routes[0])
puts "Enter the name of the train to the first station of the route"
  @stations[0].train_arrival(@trains[0])
  @stations[0].train_arrival(@trains[1])
  @stations[0].train_arrival(@trains[2])
  @stations[0].train_arrival(@trains[3])
puts ""

puts "8. Add wagon a train"
#Passanger
  @trains[0].add_wagons(@wagons[0])
  @trains[1].add_wagons(@wagons[0])
#Cargo
  @trains[2].add_wagons(@wagons[1])
  @trains[3].add_wagons(@wagons[1])
  @trains[0].show_wagons
  @trains[1].show_wagons
  @trains[2].show_wagons
  @trains[3].show_wagons
puts ""

puts "9. Delete wagon a train"
  @trains[0].delete_wagons
  @trains[1].delete_wagons
  @trains[2].delete_wagons
  @trains[3].delete_wagons
  @trains[0].show_wagons
  @trains[1].show_wagons
  @trains[2].show_wagons
  @trains[3].show_wagons
puts ""

puts "10. Move the train forward and backward along the route"
#вперед
  @trains[1].current_station.departure(@trains[1])
  @trains[1].move_forward
  @trains[1].current_station.train_arrival(@trains[1])

  @trains[2].current_station.departure(@trains[2])
  @trains[2].move_forward
  @trains[2].current_station.train_arrival(@trains[2])

  @trains[2].current_station.departure(@trains[2])
  @trains[2].move_forward
  @trains[2].current_station.train_arrival(@trains[2])

  @trains[2].current_station.departure(@trains[2])
  @trains[2].move_forward
  @trains[2].current_station.train_arrival(@trains[2])

  @trains[3].current_station.departure(@trains[3])
  @trains[3].move_forward
  @trains[3].current_station.train_arrival(@trains[3])

  @trains[3].current_station.departure(@trains[3])
  @trains[3].move_forward
  @trains[3].current_station.train_arrival(@trains[3])

  @trains[3].current_station.departure(@trains[3])
  @trains[3].move_forward
  @trains[3].current_station.train_arrival(@trains[3])

  @trains[3].current_station.departure(@trains[3])
  @trains[3].move_forward
  @trains[3].current_station.train_arrival(@trains[3])
#назад
  @trains[2].current_station.departure(@trains[2])
  @trains[2].move_back
  @trains[2].current_station.train_arrival(@trains[2])

  @trains[3].current_station.departure(@trains[3])
  @trains[3].move_back
  @trains[3].current_station.train_arrival(@trains[3])

#текущая станция
  @trains[0].show_current_station
  @trains[1].show_current_station
  @trains[2].show_current_station
  @trains[3].show_current_station
puts ""

puts "11. View the list of trains at the station"
  @stations.each_with_index do|station, index| puts "#{station.name}:"
  station.trains.select do|train|
  print "#{train.number} - #{train.type};"
puts ""
 end
end








