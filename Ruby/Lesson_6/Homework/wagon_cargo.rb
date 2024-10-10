class WagonCargo < Wagon
  def initialize
    @type = CARGO_TYPE
    super
  end

  protected

  def validate!
    super
    raise "The type of waggon is incorrect" if type != CARGO_TYPE
  end
end
