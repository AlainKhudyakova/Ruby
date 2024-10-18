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

  @stations = []
  @trains = []
  @routes = []
  @wagons = []


attempt = 0

#1
  def create_station
    begin
    puts "Create a station:"
    name = gets.chomp.to_s.capitalize
    @stations << Station.new(name)
    puts "The Station \"#{name}\" has been created"
    puts "List of station"
    @stations.each_with_index {|val, index| puts "#{index + 1}. #{val.name}" }
    rescue StandardError => e
    puts e
    end
  end

#2
  def create_train
      begin
      puts "Create number a train:"
      number = gets.chomp
      puts "Enter the type of the train : cargo or passanger"
      type = gets.chomp.capitalize
    if type == "Cargo"
      @trains << TrainCargo.new(number)
      puts "The \"#{type}\" train with number : \"#{number}\" has been created"
    elsif type == "Passenger"
      @trains << TrainPassenger.new(number)
      puts "The \"#{type}\" train with number : \"#{number}\" has been created"
    else
      puts "Enter the required train type"
    end
    puts "Specify company:"
    company = gets.chomp
    @trains[-1].specify_company(company)
    rescue StandardError => e
    puts e
    end
  @trains.each_with_index do |train, index|
    puts "#{index + 1}. #{train.number} - #{train.type} produced by #{train.show_company}"
    end 
  end

#3
  def create_route
    puts "initial_point:"
    @initial_point = station_select
    puts "final_point:"
    @final_point = station_select
    @routes << Route.new(@initial_point, @final_point)
    puts "Route #{@initial_point.name} - #{@final_point.name} has been created"
  end

#4
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
        total_seats = gets.chomp.to_i
        @wagons << WagonCargo.new(number, total_seats)
    elsif type == "Passenger"
        puts "Enter the number of seats for this wagon:"
        total_seats = gets.chomp.to_i
        @wagons << WagonPassenger.new(number, total_seats)
    else
      puts "Enter a correct type of the wagon"
      return
    end
    @wagons[-1].specify_company(company_name)
    puts "The \"#{type}\" wagon (\"#{type == "Cargo" ? total_seats : total_seats}\") has been created by \"#{company_name}\" "
    rescue StandardError => e
      puts e
    end
    display_wagons
  end

  def display_wagons
    @wagons.each_with_index do |wagon, index| 
      puts "#{index + 1}. Wagon number: #{wagon.number}, Type: #{wagon.type}, Produced by: #{wagon.show_company}"
    end
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
    route.delete_station(station)
    route.show_route_stations
  end

#7
  def assign_route
    train = train_select
    return puts "Train not select." unless train 
  
    route = route_select
    return puts "Route not selected." unless route 
  
    if train.route
      puts "The route has already been set for the train #{train.number}."
    else
      train.assign_route(route)
      @initial_point.train_arrival(train)
      puts "The route has been successfully assigned!"
      train.show_train_route
      train.show_current_station
    end
  end

#8
  def add_wagons
    train = train_select
    wagon = wagon_select
    train.add_wagons(wagon)
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
      train.move_forward
      train.current_station.train_arrival(train)
    elsif direction == "b"
      train.current_station.departure(train)
      train.move_back
      train.current_station.train_arrival(train)
    else
      puts "There is no such direction try again"
    end
    train.show_current_station
    train.show_train_route
  end

#11
  def show_trains_on_stations
    @stations.each_with_index do |station, index|
      puts "#{index}. #{station.name}:"
      station.all_trains { |train| print " #{train.number} - #{train.type};" }
      puts ""
    end
  end

#12
def show_wagons_at_trains
  @trains.each_with_index do |train, index|
    puts "#{train.type.capitalize} train(#{train.number}) has wagon(s):"
    train.all_wagons.each do |wagon|
      if wagon.type == Train::CARGO_TYPE
        puts "#{wagon.type.capitalize} wagon(#{wagon.number}) - #{wagon.free_seats}/#{wagon.free_seats} volume"
      elsif wagon.type == Train::PASSENGER_TYPE
        puts "#{wagon.type.capitalize} wagon(#{wagon.number}) - #{wagon.free_seats}/#{wagon.free_seats} seats"
      else
      end
    end
    puts ""
  end
end

#доп. функциий для внутренних процессов
  def train_select
    puts "List of the trains:"
    @trains.each_with_index {|val, index| puts "#{index + 1}. #{val.number}" }
    puts "Enter one of the #{@trains.length} train(s):"
    num = gets.chomp.to_i
    @trains[num - 1]
  end

  def station_select
    puts "List of the stations:"
    @stations.each_with_index {|val, index| puts "#{index + 1}. #{val.name}" }
    puts "Enter the number of the station from list above:"
    num = gets.chomp.to_i
    @stations[num - 1]
  end

  def route_select
    puts "List of the routes:"
    @routes.each_with_index {|val, index| puts "#{index + 1}. #{val.stations[0].name} - #{val.stations[-1].name}" }
    puts "Enter number of the route:"
    num = gets.chomp.to_i
    @routes[num - 1]
  end

  def wagon_select
    puts "Enter the number of the type:"
    @wagons.each_with_index {|wagon, index| puts "#{index + 1}.#{wagon.type}" }
    num = gets.chomp.to_i
    @wagons[num - 1]
  end

  def commands
    puts "Commands:"
    puts "1. Create station"
    puts "2. Create train"
    puts "3. Create route"
    puts "4. Create wagon"
    puts "5. Create station route"
    puts "6. Delete station route"
    puts "7. Assign route"
    puts "8. Add wagon a train"
    puts "9. Delete wagon a train"
    puts "10. Move train"
    puts "11. Show trains on stations"
    puts "12. Show wagon on trains"
    puts "help - list of commands"
    puts "exit"
  end
  
    puts "Welcome to the railway station management system!"
    puts "Enter help to view the list of commands"
  
  begin
    loop do
      print "> "
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
        assign_route
        when '8'
        add_wagons
        when '9'
        delete_wagons
        when '10' 
        move_train
        when '11'
        show_trains_on_stations
        when '12'
        show_wagons_at_trains
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
  end