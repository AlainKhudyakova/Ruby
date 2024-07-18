class WagonPassenger < Wagon
 def initialize
   @type = :passenger
 end

 protected

 def validate!
   raise "The type of waggon is incorrect" if type != :passenger
   
 end
end
