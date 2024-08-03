class WagonPassenger < Wagon

  attr_accessor :total_seats
  attr_reader :busy_seats, :free_seats

  def initialize
    @type = PASSENGER_TYPE
    @busy_seats = 0
    super
    @free_seats = @total_seats
  end

  def take_seat
    self.busy_seats += 1 if busy_seats != total_seats
    self.free_seats -= 1 if free_seats != 0
  end

  protected

  def validate!
    super
    raise "The type of waggon is incorrect" if type != PASSENGER_TYPE
  end

  private

  attr_writer :busy_seats, :free_seats
end
