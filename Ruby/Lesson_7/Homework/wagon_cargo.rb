class WagonCargo < Wagon
  attr_reader :total_volume, :occupied_volume

  def initialize(number, total_volume)
    super(number, 0, total_volume, CARGO_TYPE)
    @occupied_volume = 0
  end

  def occupy_space(volume)
    if volume <= free_volume
      @occupied_volume += volume
    else
      puts 'Not enough free volume!'
    end
  end

  def free_volume
    total_volume - occupied_volume
  end

  def display_volume_info
    puts "Total Volume: #{total_volume}, Occupied Volume: #{occupied_volume}, Free Volume: #{free_volume}"
  end

  protected

  def validate!
    super
    raise 'The type of wagon is incorrect' if type != CARGO_TYPE
  end
end
