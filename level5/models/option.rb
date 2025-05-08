require_relative './concerns/validable'

class Option
  include Validable

  TYPES = [:gps, :baby_seat, :additional_insurance]

  attr_reader :id, :rental_id, :type

  def initialize(id: nil, rental_id: nil, type: nil)
    @id = id
    @rental_id = rental_id
    @type = type
  end

  private

  def validate
    errors << "Invalid ID" unless id.is_a?(Integer) && id > 0
    errors << "Invalid rental_id" unless rental_id.is_a?(Integer) && rental_id > 0
    errors << "Invalid type" unless type.is_a?(Symbol) && TYPES.include?(type)
    super
  end
end