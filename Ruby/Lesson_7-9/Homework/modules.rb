module Company
  attr_reader :company_name

  def specify_company(name)
    self.company_name = name
  end

  def show_company
    company_name
  end

  protected

  attr_writer :company_name
end

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
    protected
    def register_instance
      self.class.instances += 1
    end
  end
end

module Attrs
  def attr_accessor_with_history (*args)
    args.each do |arg|
      var_arg = "@#{arg}".to_sym
      var_arg_hist = "@#{arg}_history".to_sym

      define_method(arg.to_sym) {instance_variable_get (var_arg)}

      define_method("#{arg}=") do |value|
        instance_variable_set(var_arg_hist, [])unless instance_variable_get(var_arg_hist)
        instance_variable_set(var_arg, value)
        hist = instance_variable_get(var_arg_hist)
        hist << value
        instance_variable_set(var_arg_hist, hist)
      end
      define_method("#{arg}_history".to_sym) { instance_variable_get(var_arg_hist)}
    end
  end

  def strong_attr_acessor (arg, class_type)
    var_arg = "@#{arg}".to_sym

    define_method(arg) {instance_variable_get (var_arg) }
    define_method("#{arg}=".to_sym) do |value|
      raise 'Error TypeMatch' unless value.is_a?(class_type)
        instance_variable_set(var_arg, value)
    end
  end
end


module Validation

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(target, val_type_name, *args)
      @validations ||= {}
      @validations[target] = {val_type_name => [*args]}
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    NUMBER_FORMAT = /^\w{3}-*\w{2}$/
    RAILWAYSTATION_NAME_PATTERN = /[a-zA-Z]{3,}/

    def validate!
      if self.class.validations
        if self.class.validations.each do |validation|
            target = validation[0]
            val = validation[1].first
            val_type = val.first
            val_params = val.last
            self.send(val_type, target, val_params)
          end
          return true
        else
          return false
        end
      end
    end

    def presence(target, *args)
      var = self.instance_variable_get("@#{target}")
      raise "#{target} can't be empty" if var.nil? || (var.is_a?(String) && var.empty?)
    end

    def type(target, expected_class)
      var = instance_variable_get("@#{target}")
      raise "#{target} must be a #{expected_class}" unless var.is_a?(expected_class)
    end

    def format(target, format_pattern)
      var = instance_variable_get("@#{target}")
      raise "Wrong format for #{target}" if var !~ format_pattern
    end
  end
end