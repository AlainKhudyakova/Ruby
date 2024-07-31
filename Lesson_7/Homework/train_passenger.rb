class TrainPassenger < Train
 def initialize (number)
   @type = PASSENGER_TYPE
   super
 end

 protected

 def validate!
   super
   raise "The type of train is incorrect" if type != PASSENGER_TYPE
   
 end
end
