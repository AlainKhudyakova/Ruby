class WagonCargo < Wagon
  attr_reader :total_volume, :occupied_volume

  def initialize(number, total_volume)
    #raise "Total volume must be a positive number" if total_volume <= 0
    super(number, 0, total_volume, CARGO_TYPE)
    #@type = CARGO_TYPE
    #@total_seats = total_seats
    @occupied_volume = 0 
  end

  #def occupy_space(volume)
  #  if  volume <= available_space
  #    @occupied_volume += volume
  #  else
  #    puts "Not  enough free volume!"
  #  end
  #end

  def occupy_space(volume)
    if volume <= free_volume
      @occupied_volume += volume
    else
      puts "Not enough free volume!"
    end
  end


  def free_volume
    total_volume - occupied_volume
    
  end

  def display_volume_info
    puts "Total Volume: #{total_volume}, Occupied Volume: #{occupied_volume}, Free Volume: #{free_volume}"
  end

  #def take_seats(volume)
  #  raise "it's too much available capacity is #{@free_seats}" unless @free_seats >= volume
  #  @busy_seats += volume
  #end

  protected

  def validate!
    super
    raise "The type of waggon is incorrect" if type != CARGO_TYPE
  end
  #def validate!
  #  super
  #  raise "The type of wagon is incorrect" unless @type == CARGO_TYPE
  #end
end
