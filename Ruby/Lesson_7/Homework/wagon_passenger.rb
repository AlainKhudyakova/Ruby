class WagonPassenger < Wagon
  def initialize(number, total_seats)
    @type = PASSENGER_TYPE
    super
  end

  def take_seats
    raise "Sorry there are no an available seats yet" unless @free_seats.positive?
    @busy_seats += 1
  end

  protected

  def validate!
    super
    raise "The type of waggon is incorrect" if type != PASSENGER_TYPE
  end
end
