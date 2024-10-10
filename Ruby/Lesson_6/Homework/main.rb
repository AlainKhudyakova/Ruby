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


class RailRoad
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end
end

attempt = 0

  def commands
    puts "Commands:"
    puts "1. Create station"
    puts "2. Create train"
    puts "3. Create route"
    puts "4. Create wagon"
    puts "5. Create station route"
    puts "6. Delete station route"
    puts "7. Adding train route"
    puts "8. Add wagon a train"
    puts "9. Delete wagon a train"
    puts "10. Move train"
    puts "11. Show trains on stations"
    puts "help - list of commands"
    puts "exit"
  end

  puts "Welcome to the railway station management system!"
  puts "Enter help to view the list of commands"

  loop do
    print '> '
    input = gets.strip

    begin
    case input
    when 'exit'
      break
    when 'help'
      commands  
    when '1'
      create_station
    when '2'
      create_train
    when '3'
      create_route
    when '4'
      create_wagon
    when '5'
      create_station_route
    when '6'
      delete_station_route
    when '7'
      set_route
    when '8'
      add_wagons
    when '9'
      delete_wagon_train
    when '10' 
      move_train
    when '11'
      show_trains_on_stations
    else
      puts "Command #{input} not found!" 
    end
  rescue StandardError => e
    attempt += 1
    puts "Error has occured: #{e.message}. Try again!"
    puts "Attempts: #{attempt}" if attempt.positive?
    retry if attempt > 3
    puts "Attempts are exhausted. Try again later."
    attempt = 0
    next
  end
end

#1
  def create_station
    puts "Create a station:"
    name = gets.chomp
    @stations << Station.new(name)
    puts "Station \"#{name}\" created"
  end

#2
  def create_train
    puts "Create number a train:"
    number = gets.chomp
    puts "Enter type train : cargo or passanger"
    type = gets.chomp.capitalize
  if type == "Cargo"
      @trains << TrainCargo.new(number)
      puts "Train \"#{type}\" number : \"#{number}\" created"
    elsif type == "Passenger"
      @trains << TrainPassenger.new(number)
      puts "Train \"#{type}\" number : \"#{number}\" created"
    else
      puts "Enter the required train type"
    end
    @trains.each_with_index {|val, index| puts "#{index + 1}. #{val.number} - #{val.type} "}
  end

#3
  def create_route
    puts "initial_point:"
    @initial_point = station_select
    puts "final_point:"
    @final_point = station_select
    @routes << Route.new(@initial_point, @final_point)
    puts "Route #{@initial_point.name} - #{@final_point.name} created"
  end

#4
  def create_wagon
    @wagons << WagonCargo.new
    @wagons << WagonPassenger.new
    puts @wagons
    @wagons.each_with_index {|wagon, index| puts "#{index + 1}.#{wagon.type}"}
  end

#5
  def create_station_route
    route = route_select
    station = station_select
    route.add_station(station)
    route.show_route_stations
  end

#6
  def delete_station_route
    route = route_select
    station = station_select
    route.delete_station_route(station)
    route.show_route_stations
  end

#7
  def set_route
    train = train_select
    route = route_select
    train.set_route(route)
    @initial_point.train_arrival(train)
    train.show_train_route
    train.show_current_station
  end

#8
  def add_wagons
    train = train_select
    train.add_wagons
    train.show_wagons
  end

#9
  def delete_wagons
    train = train_select
    train.delete_wagons
    train.show_wagons
  end

#10
  def move_train
    train = train_select
    puts "Train is heading: forward(f) or back(b)?"
    direction = gets.chomp
  if direction == "f"
    train.current_station.departure(train)
    train.move.forward
    train.current_station.train_arrival(train)
  elsif direction == "b"
    train.current_station.departure(train)
    train.move.back
    train.current_station.train_arrival(train)
  else
    puts ""
  end
  train.show_current_station
  train.show_train_route
  end

#11
  def show_trains_on_stations
    @stations.each_with_index do|station, index| puts "#{station.name}"
    station.trains.select do|train|
    print " #{train.number} - #{train.type};"
    puts ""
  end
  end
end

#доп. функциий для внутренних процессов
  def train_select
    puts "List of trains:"
    @trains.each_with_index {|val, index| puts "#{index + 1}. #{val.number}" }
    puts "Choose a #{@trains.length} train(s):"
    num = gets.chomp.to_i
    train = @trains[num - 1]
  end

  def station_select
    puts "List of stations:"
    @stations.each_with_index {|val, index| puts "#{index + 1}. #{val.name}" }
    puts "List a station number:"
    num = gets.chomp.to_i
    station = @stations[num - 1]
  end

  def route_select
    puts "List of the routes:"
    @routes.each_with_index {|val, index| puts "#{index + 1}. #{val.stations[0].name} - #{val.stations[-1].name}" }
    puts "Enter number of the route:"
    num = gets.chomp.to_i
    route = @routes[num - 1]
  end

  def wagon_select
    puts "Enter the number of the type:"
    @wagons.each_with_index {|wagon, index| puts "#{index + 1}.#{wagon.type}" }
    num = gets.chomp.to_i
    wagon = @wagons[num - 1]
  end