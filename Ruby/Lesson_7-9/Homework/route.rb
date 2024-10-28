class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :initial_point, :final_point

  def initialize(initial_point, final_point)
    @initial_point = initial_point
    @final_point = final_point
    @stations = [initial_point, final_point]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return 'The start and end stations cannot be delete' if not_start_and_end?(station)

    @stations.delete(station) if station_included?(station)
    'The station has been removed!'
  end

  def show_route_stations
    puts "This route consists of #{@stations.length} station(s): "
    @stations.each_with_index { |station, index| print "#{index + 1} - #{station.name};" }
    puts ''
  end

  private

  def station_included?(station)
    @stations.include?(station)
  end

  def not_start_and_end?(station)
    station == @stations[0] || station == @stations[-1]
  end
end
