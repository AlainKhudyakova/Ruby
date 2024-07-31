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

  def invalid_length?(attr, min_length = 4, max_length = 30)
    attr.size < min_length || attr.size > max_length
  end
end
