class WagonPassenger < Wagon
  def initialize
    @type = PASSENGER_TYPE
    super
  end

  protected

  def validate!
    super
    raise "The type of waggon is incorrect" if type != PASSENGER_TYPE
  end
end
