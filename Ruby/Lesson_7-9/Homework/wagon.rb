class Wagon
  include Validation
  include Company

  PASSENGER_TYPE = :passenger
  CARGO_TYPE = :cargo

  attr_reader :type, :number, :total_seats, :total_volume

  def initialize(number, total_seats = 0, total_volume = 0, type)
    @number = number
    @total_seats = total_seats
    @total_volume = total_volume
    @type = type
    validate!
  end

  def free_seats
    @total_seats - @busy_seats
  end

  def occupy_seat
    raise 'should be implemented in subclases' unless free_seats > 0

    @busy_seats += 1
  end

  def free_volume
    @total_volume - @busy_volume
  end

  #protected

  #def validate!
  #  raise NotImplementedError, 'Unable to create an object of a Class that is a parent!' if instance_of?(Wagon)
  #  raise 'Company name must be between 2 and 50 characters long' if !company_name.nil? && invalid_length?(company_name)
  #  raise 'Invalid wagon type' unless [PASSENGER_TYPE, CARGO_TYPE].include?(@type)
  #end
end
