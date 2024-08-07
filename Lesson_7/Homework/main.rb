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

  def create_station
    puts "Create a station:"
    name = gets.chomp.to_s.capitalize
    station = Station.find(name)

    if station
      puts "The station already exists"
      station
    else
    puts "Station successfully created"
    Station.new(name)
  end
end

  def create_train
    begin
      puts "Create number a train:"
      number = gets.strip
      puts "Enter type train : cargo or passenger"
      type = gets.to_i
    if Train.find(number)
      puts "The train already exists"
    elsif type == "Cargo"
      train = TrainCargo.new(number)
      train
    elsif type == "Passenger"
      train = TrainPassenger.new(number)
      train
    else 
      puts "Train successfully created "
    end
  rescue StandardError => e
    puts e
  end
end




  def create_route(routes)
    puts "Enter the name of the starting station"
    initial_point = gets.strip
    if initial_point.to_i.zero?
      Station.new(initial_point)
    else
      initial_point = initial_point.to_i - 1
    end
  end


  def create_wagon
    begin
      puts "Specify company:"
      company_name = gets.chomp
      puts "Enter the type of the wagon: cargo or passenger?"
      type = gets.chomp.capitalize
      puts "Enter the number of the wagon:"
      number = gets.chomp
    if type == "Cargo"
        puts "Enter the volume for this wagon:"
        total_seats = gets.chomp.capitalize
        WagonCargo.find(number, total_seats)
        wagon = WagonCargo.new(number, total_seats)
        @wagons[-1].specify_company(company_name)
        puts "The \"#{type}\"(\"#{total_seats}\") wagon has been created by \"#{company_name}\" "
      elsif type == "Passenger"
        puts "Enter the number of sets for this wagon:"
        total_seats = gets.chomp.capitalize
        WagonPassenger.find(number, total_seats)
        wagon = WagonPassenger.new(number, total_seats)
        @wagons[-1].specify_company(company_name)
        puts "The \"#{type}\"(\"#{total_seats}\") wagon has been created by \"#{company_name}\" "
      else
        puts "Enter a correct type of the wagon"
        end
    rescue StandardError => e
      puts e
    end
    @wagons.each_with_index{ |wagon, index| puts "#{index + 1}.#{wagon.type} produced by #{wagon.show_company}" }
  end


  def create_station_route
    route = route_select
    station = station_select
    route.add_station(station)
    route.show_route_stations
  end


  def delete_station_route
    route = route_select
    station = station_select
    route.delete_station_route(station)
    route.show_route_stations
  end


  def set_route
    train = train_select
    route = route_select
    train.set_route(route)
    @initial_point.train_arrival(train)
    train.show_train_route
    train.show_current_station
  end


  def add_wagons
    train = train_select
    wagon = wagon_select
    train.add_wagons(wagon)
    train.show_wagons
  end


  def delete_wagons
    train = train_select
    train.delete_wagons
    train.show_wagons
  end


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
    puts "There is no such direction, try again"
  end
  train.show_current_station
  train.show_train_route
  end


  def show_trains_on_stations
    @stations.each_with_index do |station, index|
      puts "#{index}. #{station.name}:"
      station.all_trains { |train| print " #{train.number} - #{train.type};"}
      puts ""
    end
  end

  def show_wagons_at_trains
    @trains.each_with_index do |train, index|
      puts "#{train.type.capitalize} train(#{train.number}) has wagon(s):"
      train.all_wagons do |wagon|
        if wagon.type == Train::CARGO_TYPE
          puts "#{wagon.type.capitalize} wagon(#{wagon.number}) - #{wagon.free_volume}/#{wagon.volume} volume"
        elsif wagon.type == Train::PASSENGER_TYPE
          puts "#{wagon.type.capitalize} wagon(#{wagon.number}) - #{wagon.free_seats}/#{wagon.seats} seats"
        else
          puts "There is no any wagon at train"
        end
      end
      puts ""
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

begin
  loop do
    print '> '
    input = gets&.strip&.downcase

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
  rescue Interrupt
    #ignored
end