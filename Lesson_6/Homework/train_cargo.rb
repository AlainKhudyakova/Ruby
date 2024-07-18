class TrainCargo < Train
 def initialize (number)
   @type = :cargo
    super
 end

 protected

 def validate!
   super
   raise "The type of train is incorrect" if type != :cargo
   
 end
end