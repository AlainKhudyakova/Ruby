
require_relative "./validate"
require_relative "./instance_counter"
require_relative "./company"
require_relative "./route"
require_relative "./station"
require_relative "./train"
require_relative "./train_cargo"
require_relative "./train_passenger"
require_relative "./wagon"
require_relative "./wagon_cargo"
require_relative "./wagon_passenger"


@stations = []
@trains = []
@routes = []
@wagons = []

puts "1. Create a station"
  @stations << Station.new("Ufa")
  @stations << Station.new("Sochi")
  @stations << Station.new("Adler")
  @stations << Station.new("Kazan")
  @stations << Station.new("Moscow")
  @stations << Station.new("Omsk")
  @stations << Station.new("Volgograd")
  @stations << Station.new("Tomsk")
  @stations << Station.new("Tobolsk")
  @stations << Station.new("Irkutsk")
  puts "Stations:"
  Station.all
  puts ""

puts "2. Create number a train"
  @trains << TrainCargo.new("001-AA")
  @trains << TrainCargo.new("AAA-02")
  @trains << TrainPassenger.new("003-BB")
  @trains << TrainPassenger.new("004-BB")
  @trains[0].specify_company("Train-Cargo")
  @trains[1].specify_company("Train-Cargo")
  @trains[2].specify_company("Train-Pas")
  @trains[3].specify_company("Train-Pas")
  puts "Test for @trains[0].Valid?: #{@trains[0].valid?}"
  puts "Test for @trains[1].Valid?: #{@trains[1].valid?}"
  puts "Test for @trains[2].Valid?: #{@trains[2].valid?}"
  puts "Test for @trains[3].Valid?: #{@trains[3].valid?}"
  puts 'Trains:'
@trains.each_with_index do |train, index|
  puts "#{index + 1}. #{train.number} - #{train.type} this train produced by #{train.show_company}"
end
  puts ""

puts "3. Create a route"
  @routes << Route.new(@stations[0], @stations[-1])
  @routes.each_with_index { |val, index| puts "#{index + 1}. #{val.stations[0].name} - #{val.stations[-1].name}" }
  puts ""

puts "4. Create wagon"

  @wagons << WagonCargo.new("WC1", 100)
  @wagons << WagonPassenger.new("WP1", 12)
  @wagons[0].specify_company("Wagon-Cargo")
  @wagons[1].specify_company("Wagon-Pas")
  @wagons[-1].take_seats
  @wagons[-1].take_seats
  @wagons[-1].take_seats
  @wagons[-2].take_seats(40)
  puts "Wagons:"
  @wagons.each_with_index do |wagon, index| 
    puts "#{index + 1} #{wagon.number}.#{wagon.type} wagon produced by #{wagon.show_company}"
  end
  print "Seats available:"
  puts @wagons[-1].free_seats
  print "Seats occupied:"
  puts @wagons[-1].busy_seats
  print "capacity_filled:"
  puts @wagons[-2].busy_seats
  print "capacity_available:"
  puts @wagons[-2].free_seats
  puts ""

puts "5. Create station route"
  @routes[0].add_station(@stations[1])
  @routes[0].add_station(@stations[2])
  @routes[0].add_station(@stations[3])
  @routes[0].add_station(@stations[4])
  @routes[0].add_station(@stations[5])
  @routes[0].add_station(@stations[6])
  @routes[0].add_station(@stations[7])
  @routes[0].add_station(@stations[8])
  @routes[0].show_route_stations
  puts ""

puts "6. Delete station route"
  @routes[0].delete_station(@stations[8])
  @routes[0].show_route_stations
  puts ""

puts "7. Set a route to the train"
  @trains[0].assign_route(@routes[0])
  @trains[1].assign_route(@routes[0])
  @trains[2].assign_route(@routes[0])
  @trains[3].assign_route(@routes[0])
  puts 'Put the particular train to the first station of the route'
  @stations[0].train_arrival(@trains[0])
  @stations[0].train_arrival(@trains[1])
  @stations[0].train_arrival(@trains[2])
  @stations[0].train_arrival(@trains[3])
  puts ""

puts "8. Add wagon a train"
#cargo
  @trains[0].add_wagons(@wagons[0])
  @trains[1].add_wagons(@wagons[0])
  @trains[0].add_wagons(@wagons[0])
  @trains[1].add_wagons(@wagons[0])
#passenger
  @trains[2].add_wagons(@wagons[1])
  @trains[3].add_wagons(@wagons[1])
  @trains[2].add_wagons(@wagons[1])
  @trains[3].add_wagons(@wagons[1])
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

puts "10. Move train"
#forward 
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
#back
@trains[2].current_station.departure(@trains[2])
@trains[2].move_back
@trains[2].current_station.train_arrival(@trains[2])

@trains[3].current_station.departure(@trains[3])
@trains[3].move_back
@trains[3].current_station.train_arrival(@trains[3])
#current_station   
@trains[0].show_current_station
@trains[1].show_current_station
@trains[2].show_current_station
@trains[3].show_current_station
puts ""

puts "11. Show trains on stations"
  @stations.each_with_index do |station, index| 
    puts "#{index + 1}. #{station.name}:"
    station.all_trains do |train|
      print "#{train.type.capitalize} train(#{train.number}) has #{train.wagons.length} wagon(s) ;"
    puts ""
    end
  end

  puts '12. View wagons at trains'
    @trains.each_with_index do |train, _index|
    puts "#{train.type.capitalize} train(#{train.number}) has wagon(s):"
    train.all_wagons.each do |wagon|
    if wagon.type == Train::CARGO_TYPE
      puts "#{wagon.type.capitalize} wagon(#{wagon.number}) - #{wagon.free_seats}/#{wagon.free_seats} capacity"
    elsif wagon.type == Train::PASSENGER_TYPE
      puts "#{wagon.type.capitalize} wagon(#{wagon.number}) - #{wagon.free_seats}/#{wagon.free_seats} seats"
    else
      puts "There is no any wagon at train"
    end
  end
  puts ""
end
