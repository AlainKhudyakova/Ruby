class WagonPassenger < Wagon
  attr_reader :total_seats, :occupied_seats

  def initialize(number, total_seats)
    super(number, total_seats, 0, PASSENGER_TYPE)
    @occupied_seats = 0
  end

  def occupy_seat
    if occupied_seats < total_seats
      @occupied_seats += 1
    else
      raise "Not enough free seats!"
    end
  end

  def free_seats
    @total_seats - @occupied_seats
  end

  def display_seats_info
    puts "Total seats: #{total_seats}, Occupied seats: #{occupied_seats}, Free seats: #{free_seats}"
  end

  protected

  def validate!
    super
    raise 'The type of wagon is incorrect' if type != PASSENGER_TYPE
  end
end
