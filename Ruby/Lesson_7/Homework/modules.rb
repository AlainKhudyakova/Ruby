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
    private

    def register_instance
      self.class.instances += 1
    end
  end
end

module Validation
  def valid?
    validate!
    true
  rescue NotImplementedError
    false
  rescue StandardError
    false
  end

  private

  def invalid_length?(attr, min_length = 2, max_length = 50)
    attr.size < min_length || attr.size > max_length
  end
end