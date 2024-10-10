class Wagon
  include Validation
  include Company

  PASSENGER_TYPE = :passenger
  CARGO_TYPE = :cargo

  attr_reader :type, :number, :total_seats, :busy_seats

  def initialize(number, total_seats)
    @number = number
    @total_seats = total_seats
    @busy_seats = 0
    @free_seats = total_seats
    validate!
  end

  def free_seats
    @free_seats = @total_seats - @busy_seats
  end

  def take_seats
    raise "should be implemented in subclases"
  end

  protected

  def validate!
    raise NotImplementedError, "Unable to create an object of a Class that is a parent!" if instance_of?(Wagon)
    raise "Company name must be between 2 and 50 characters long" if !company_name.nil? && invalid_length?(company_name)
  end

private

  def generate_number
    rand(10_000...100_000)
  end
end
