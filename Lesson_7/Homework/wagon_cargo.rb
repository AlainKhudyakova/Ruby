class WagonCargo < Wagon

  def initialize(number, total_seats)
    @type = CARGO_TYPE
    super
  end

  def take_seats(volume)
    raise "It's too much available volume is #{@free_seats}" unless @free_seats >= volume
    @busy_seats += volume
  end

  protected

  def validate!
    super
    raise "The type of waggon is incorrect" if type != CARGO_TYPE
  end
end
