class Wagon
  include Validation
  include Company

  PASSENGER_TYPE = :passenger
  CARGO_TYPE = :cargo

  attr_reader :type

  def initialize
    validate!
  end

  protected

  def validate!
    raise NotImplementedError, "Unable to create an object of a Class that is a parent!" if instance_of?(Wagon)
    raise "Company name must be between 2 and 50 characters long" if !company_name.nil? && invalid_length?(company_name)
  end
end
