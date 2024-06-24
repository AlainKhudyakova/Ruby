require_relative "Route"
require_relative "Station"
require_relative "Train"
require_relative "Train_cargo"
require_relative "Train_passanger"
require_relative "Wagon"
require_relative "Wagon_cargo"
require_relative "Wagon_passanger"

class RailRoad
 def initialize
  @stations = []
  @trains = []
  @routes = []
  @wagons = []
 end

 def start
  loop do
   show_menu
   command = gets.chomp.to_i
   run(command)
  end
 end

 private
 def show_menu
  puts "Выберите команду:"
  puts "1. Создать станцию"
  puts "2. Создать поезд"
  puts "3. Создать маршрут"
  puts "4. Создать вагон"
  puts "5. Создать маршрут станции"
  puts "6. Удалить маршрут станции"
  puts "7. Назначить маршрут поезду"
  puts "8. Добавить вагон к поезду"
  puts "9. Отцеплять вагоны от поезда"
  puts "10. Перемещать поезд по маршруту вперед и назад"
  puts "11. Просматривать список станций и список поездов на станции"
  puts "12. Закрыть меню"
 end

 def run(command)
  case command
  when 1 then create_station
  when 2 then create_train
  when 3 then create_route
  when 4 then create_wagon
  when 5 then create_station_route
  when 6 then delete_station_route
  when 7 then assing_train_route
  when 8 then add_wagon_train
  when 9 then delete_wagon_train
  when 10 then move_train
  when 11 then show_trains_on_stations
  when 12 then exit
  else
   puts "не нашли необходимую команду, попробуйте снова" 
  end
 end
end

def create_station
 puts "Создайте станцию:"
  name = gets.chomp
   @stations << Station.new(name)
 puts "Станция \"#{name}\" создана"
 puts "Список станций"
   @stations.each_with_index {|val, index| puts "#{index + 1}. #{val.m=name}" }
end

def create_train
 puts "Создайте номер поезда:"
  number = gets.chomp
 puts "Введите тип поезда : грузовой или пассажирский"
  type = gets.chomp.capitalize
if type == "Cargo"
   @trains << TrainCargo.new(number)
 puts "Поезд \"#{type}\" с номером : \"#{number}\" создан"
elsif type == "Passanger"
   @trains << TrainPassanger.new(number)
 puts "Поезд \"#{type}\" с номером : \"#{number}\" создан"
else
 puts "Введите необходимый тип поезда"
end
   @trains.each_with_index {|val, index| puts "#{index + 1}. #{val.number} - #{val.type} "}
end

def create_route
 puts "initial_point:"
   @initial_point = station_select
 puts "final_point:"
   @final_point = station_select
   @routes << Route.new(@initial_point, final_point)
 puts "Маршрут #{@initial_point.name} - #{final_point.name} создан"
end

def create_wagon
   @wagons << WagonCargo.new
   @wagons << WagonPassanger.new
 puts @wagons
   @wagons.each_with_index {|wagon, index| puts "#{index + 1}.#{wagon.type}"}
end

def create_station_route
 route = route_select
 station = station_select
 route.add.station(station)
 route.show_route_stations
end

def delete_station_route
 route = route_select
 station = station_select
 route.delete_station_route(station)
 route.show_route_stations
end

def assing_train_route
 train = train_select
 train = route_select
 train.assing_train_route(route)
  @initial_point.train_arrival(train)
 train.show_train_route
 train.show_current_station
end

def add_wagon_train
 train = train_select
 train.add_wagons
 train.show_wagons
end

def move_train
 train = train_select
 puts "Поезд направляется: вперед(f) или назад(b)?"
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
  puts "не нашли необходимую команду, попробуйте снова"
 end
  train.show_current_station
  train.show_train_route
end
