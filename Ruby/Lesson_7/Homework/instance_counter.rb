module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances 
      @instances ||= 0
    end

  attr_writer :instances
  end

  module InstanceMethods
    private
    
    def register_instance
      self.class.instances += 1
    end
  end
end