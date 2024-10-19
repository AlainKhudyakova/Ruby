class WagonPassenger < Wagon
  attr_reader :total_seats, :occupied_seats

  def initialize(number, total_seats)
    super(number, total_seats, 0, PASSENGER_TYPE)
    #@type = PASSENGER_TYPE
    #@total_seats = total_seats
    @occupied_seats = 0
  end

  #def occupy_seat
  #  if available_seats > 0 
  #    @occupied_seats += 1
  #  else
  #    puts "There are not free seats!"
  #  end
  #end

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

  #def take_seats
  #  raise "Sorry there are no an available seats yet" unless @free_seats.positive?
  #  @busy_seats += 1
  #end

  protected

  def validate!
    super
    raise "The type of wagon is incorrect" if type != PASSENGER_TYPE
  end
end
