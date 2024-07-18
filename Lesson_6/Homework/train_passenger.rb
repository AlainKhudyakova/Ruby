class TrainPassenger < Train
 def initialize (number)
   @type = :passenger
   super
 end

 protected

 def validate!
   super
   raise "The type of train is incorrect" if type != :passenger
   
 end
end
