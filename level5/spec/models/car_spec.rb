require 'spec_helper'

RSpec.describe Car do
  describe '#initialize' do
    it 'creates a car with valid attributes' do
      car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
      expect(car.id).to eq(1)
      expect(car.price_per_day).to eq(2000)
      expect(car.price_per_km).to eq(10)
    end
  end

  describe '#valid?' do
    it 'returns true for valid car' do
      car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
      expect(car.valid?).to be_truthy
      expect(car.errors).to be_empty
    end

    it 'returns false for invalid car' do
      car = Car.new(id: -1, price_per_day: -2000, price_per_km: -10)
      expect(car.valid?).to be_falsey
      expect(car.errors).to match_array(["Car", "Invalid ID", "Invalid price_per_day", "Invalid price_per_km"])
    end

    it 'returns false for missing attributes' do
      car = Car.new(price_per_day: 2000)
      expect(car.valid?).to be_falsey
      expect(car.errors).to match_array(["Car", "Invalid ID", "Invalid price_per_km"])
    end
  end
end