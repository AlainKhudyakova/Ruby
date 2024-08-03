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
    puts "12. Show stations"
    puts "13. Show wagons"
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
    when '12'
      show_stations
    when '13'
      show_wagons
    else
      puts "Command #{input} not found!" 
    end
  rescue StandardError => e
    attempt += 1
    puts "Error has occured: #{e.massege}. Try again!"
    puts "Attempts: #{attempt}" if attempt.positive?
    retry if attempt > 3
    puts "Attempts are exhausted. Try again later."
    attempt = 0
    next
  end
end


  def create_station
    puts "Create a station:"
    name = gets.chomp
    @stations << Station.new(name)
    puts "Station \"#{name}\" created"
  end


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


  def create_route
    puts "initial_point:"
    @initial_point = station_select
    puts "final_point:"
    @final_point = station_select
    @routes << Route.new(@initial_point, @final_point)
    puts "Route #{@initial_point.name} - #{@final_point.name} created"
  end


  def create_wagon
    @wagons << WagonCargo.new
    @wagons << WagonPassenger.new
    puts @wagons
    @wagons.each_with_index {|wagon, index| puts "#{index + 1}.#{wagon.type}"}
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


  def add_wagons(train = nil)
    if train.nil?
      puts "Choose a train:"
      train = create_train
    end

    puts "Enter the number of wagons:"
    print "> "
    wagon_count = gets.to_i
    if train.type == Wagon::PASSENGER_TYPE
      puts "Specify the number of seats:"
      print "> "
      total_volume = gets.to_i
    else
      puts "Specify the total volume of the wagon:"
      print "> "
      total_volume = gets.to_i
    end

    wagon_count.times do
      wagon = if train.type == Train::PASSENGER_TYPE
                WagonPassenger.new { |p| p.total_seats = total_seats }
              else
                WagonCargo.new { |p| p.total_volume = total_volume}
              end
      train.add_wagon(wagon)
    end
    puts "Wagons added"
    
  end

  def delete_wagons
    puts "Choose a train:"
    train = create_train

    puts "Enter the number of wagons:"
    wagon_count = gets.to_i

    wagon_count.times do
      wagon = train.type == Train::PASSENGER_TYPE ? WagonPassanger.new : WagonCargo.new
      puts train.delete_wagon(wagon)
    end
    puts "Wagons deleted"
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
    puts ""
  end

  if train.wagons.empty?
    puts "\tThe train doesn't have waggons, we need to add waggons!"
    add_wagons(train)
    if train.type == Train::PASSENGER_TYPE
      train.each_wagon do |wagon|
        rand(0..wagon.total_seats).times do
          wagon.take_seat
    end
  end
  puts "Passengers boarded the train"
  else
    train.each_wagon do |wagon|
      volume = rand(0..wagon.total_volume)
      wagon.take_volume(volume)
    end
    puts "The train was loaded"
  end

  def choice_route(routes)
    routes.each_with_index do |route, index|
      print " #{index + 1}: "
      route.all_stations
      puts
    end
    print '> '
    route = gets.to_i
    routes[route - 1]
  end
  
  def choice_train
    Train.all.each_with_index do |train, index|
      type = train.type == Train::PASSENGER_TYPE ? "passenger" : "cargo"
      puts "\t#{index + 1}. #{train.number}, type train: #{type}"
    end
    print "> "
    train = gets.to_i
    Train.all[train - 1]
  end

  def train_select
    Train.all.each_with_index do |train, index|
      type = train.type == Train::PASSENGER_TYPE ? "passenger": "cargo"
      puts "\t#{index + 1}. #{train.number}, type train #{type}"
    end
    print '> '
    train = gets.to_i
    Train.all[train - 1]
  end

  def show_stations
    puts "List of stations:"
    Statoin.all.each_with_index do |station, index|
      puts " #{index + 1} - #{station.name}"
    end
  end
  end

  def show_trains_on_stations
    puts "Show a list of trains for all stations or for one? (Y/N)"
    print "> "
    input = gets.chomp.downcase

    if input == "y"
      Station.all.each do |station|
        puts "List of trains at the station: #{station.name}"

        if station.trains.empty?
          puts "There are no trains at the station"
        else
          display_trains_for_station(station)
        end
      end
    else
      puts "Choose a station :"
      show_stations
      print "> "
      station = gets.to_i
      station = Station.all[station - 1]

      puts "List of trains at the station: #{station.name}"
      display_trains_for_station(station)
    end
end

  def display_trains_for_station(station)
    station.each_train_with_index do |train, index|
      type = train.type == Train::PASSENGER_TYPE ? "passenger" : "cargo"
      index += 1
      wagons = train.wagons.saze
      puts "\t#{index}. number train: #{train.number}, type train: #{type}, number of waggons: #{wagons} "
    end
  end

  def show_wagons
    puts "Select a train to view the list of waggons: #{train.number}"
    train = train_select

    puts "List of waggons by the train"
    
    train.each_wagon_with_index do |wagon, index|
      type = wagon.type == Train::PASSENGER_TYPE ? "passenger"  : "cargo"
      index += 1
      puts "\t#{index}. number wagon: #{wagon.number}"
      if wagon.type == Train::PASSENGER_TYPE
        puts "\t\tnumber of seats available: #{wagon.free_seats}, busy sets: #{wagon.busy_seats}"
      else
        puts "\t\tamount of free volume: #{wagon.free_volume}, busy volume: #{wagon.busy_volume}"
      end
    end
  end
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