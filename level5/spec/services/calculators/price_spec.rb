require 'spec_helper'

RSpec.describe Calculators::Price do
  let(:calculator) { described_class.new(
    rental: build_rental, 
    car: build_car, 
    options: [
      build_option(id: 1, type: :gps), 
      build_option(id: 2, type: :baby_seat), 
      build_option(id: 3, type: :additional_insurance)])}

  describe '#price' do
    context 'when calculating price with distance, time and options' do
      it 'returns the correct price' do
        expect(calculator.price(option_types: [:gps, :baby_seat])).to eq(8700) # (10 * 100) + (3 * 500) + (3 * 200) + (2000*1) + (2000*0.9) +(2000*0.9)
      end
    end

    context 'when calculating price without distance' do
      it 'returns the correct price' do
        expect(calculator.price(with_distance: false, option_types: [:gps, :baby_seat])).to eq(7700) # (3 * 500) + (3 * 200) + (2000*1) + (2000*0.9) +(2000*0.9)
      end
    end

    context 'when calculating price without time' do
      it 'returns the correct price' do
        expect(calculator.price(with_time: false, option_types: [:gps, :baby_seat])).to eq(3100) # (10 * 100) + (3 * 500) + (3 * 200)
      end
    end

    context 'when calculating price without options' do
      it 'returns the correct price' do
        expect(calculator.price(with_options: false)).to eq(6600) # (10 * 100) + (2000*1) + (2000*0.9) +(2000*0.9)
      end
    end
  end

  describe '#price_by_options' do
    it 'calculates the price for selected options' do
      expect(calculator.send(:price_by_options, [:gps, :baby_seat])).to eq(2100) # (3 * 500) + (3 * 200)
    end

    it 'returns 0 when no matching options are provided' do
      expect(calculator.send(:price_by_options, [:wifi])).to eq(0)
    end
  end

  describe '#price_by_distance' do
    it 'calculates the correct distance price' do
      expect(calculator.send(:price_by_distance)).to eq(1000) # 100 * 10
    end
  end

  describe '#price_by_time' do
    it 'calculates the correct time price with discounts' do
      expect(calculator.send(:price_by_time)).to eq(5600) # (1*2000) + (0.9*2000) + (0.9*2000)
    end
  end

  describe '#time_discount_percentage' do
    it 'returns 1 for the first day' do
      expect(calculator.send(:time_discount_percentage, 1)).to eq(1)
    end

    it 'returns 0.9 for days 2 to 4' do
      expect(calculator.send(:time_discount_percentage, 2)).to eq(0.9)
      expect(calculator.send(:time_discount_percentage, 4)).to eq(0.9)
    end

    it 'returns 0.7 for days 5 to 10' do
      expect(calculator.send(:time_discount_percentage, 5)).to eq(0.7)
      expect(calculator.send(:time_discount_percentage, 10)).to eq(0.7)
    end

    it 'returns 0.5 for days greater than 10' do
      expect(calculator.send(:time_discount_percentage, 11)).to eq(0.5)
    end
  end

  describe '#option_price' do
    it 'calculates the correct price for GPS option' do
      expect(calculator.send(:option_price, build_option(type: :gps))).to eq(1500) # 3 * 500
    end

    it 'calculates the correct price for baby seat option' do
      expect(calculator.send(:option_price, build_option(type: :baby_seat))).to eq(600) # 3 * 200
    end

    it 'calculates the correct price for additional insurance option' do
      expect(calculator.send(:option_price, build_option(type: :additional_insurance))).to eq(3000) # 3 * 1000
    end

    it 'returns 0 for unknown option types' do
      expect(calculator.send(:option_price, build_option(type: :wifi))).to eq(0)
    end
  end
end