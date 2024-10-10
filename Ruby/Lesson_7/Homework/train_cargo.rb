class TrainCargo < Train
  def initialize (number)
    @type = CARGO_TYPE
    super
  end

  protected

  def validate!
    super
    raise "The type of train is incorrect" if type != CARGO_TYPE
  end
end