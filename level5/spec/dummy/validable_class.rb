class ValidableClass
  include Validable

  def validate
    errors << 'Invalid' if @invalid
    raise ArgumentError, errors if errors.any?
  end

  def invalidate!
    @invalid = true
  end
end