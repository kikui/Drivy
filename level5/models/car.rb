require_relative './concerns/validable'

class Car
  include Validable
  
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(id: nil, price_per_day: nil, price_per_km: nil)
    @id = id
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end

  private

  def validate
    errors << "Invalid ID" unless id.is_a?(Integer) && id > 0
    errors << "Invalid price_per_day" unless price_per_day.is_a?(Integer) && price_per_day > 0
    errors << "Invalid price_per_km" unless price_per_km.is_a?(Integer) && price_per_km > 0
    super
  end
end