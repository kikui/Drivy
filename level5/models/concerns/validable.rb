module Validable
  def valid?
    errors.clear
    validate
    true
  rescue ArgumentError
    false
  end

  def errors
    @errors ||= []
  end

  private

  def validate
    return if errors.empty?

    errors.prepend("#{self.class}")
    raise ArgumentError, errors.join(", ")
  end
end