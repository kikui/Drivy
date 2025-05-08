require 'spec_helper'

RSpec.describe Rental do
  let(:valid_rental) { build_rental }

  describe '#initialize' do
    it 'initializes with valid attributes' do
      expect(valid_rental.id).to eq(1)
      expect(valid_rental.car_id).to eq(1)
      expect(valid_rental.start_date).to eq(Date.parse('2023-01-01'))
      expect(valid_rental.end_date).to eq(Date.parse('2023-01-03'))
      expect(valid_rental.distance).to eq(100)
    end
  end

  describe '#duration' do
    it 'calculates the duration correctly' do
      expect(valid_rental.duration).to eq(3)
    end
  end

  describe '#valid?' do
    context 'with valid attributes' do
      it 'returns true' do
        expect(valid_rental.valid?).to be true
      end
    end

    context 'with invalid attributes' do
      context 'invalid ID' do
        it 'returns false with nil value' do
          rental = build_rental(id: nil)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid ID")
        end

        it 'returns false with negative value' do
          rental = build_rental(id: -1)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid ID")
        end

        it 'returns false with non-integer value' do
          rental = build_rental(id: 'abc')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid ID")
        end

        it 'returns false with zero value' do
          rental = build_rental(id: 0)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid ID")
        end

        it 'returns false with missing value' do
          rental = build_rental(id: nil)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid ID")
        end

        it 'returns false with empty value' do
          rental = build_rental(id: '')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid ID")
        end
      end

      context 'invalid car_id' do
        it 'returns false with nil value' do
          rental = build_rental(car_id: nil)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid car_id")
        end

        it 'returns false with negative value' do
          rental = build_rental(car_id: -1)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid car_id")
        end

        it 'returns false with non-integer value' do
          rental = build_rental(car_id: 'abc')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid car_id")
        end

        it 'returns false with zero value' do
          rental = build_rental(car_id: 0)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid car_id")
        end

        it 'returns false with missing value' do
          rental = build_rental(car_id: nil)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid car_id")
        end

        it 'returns false with empty value' do
          rental = build_rental(car_id: '')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid car_id")
        end
      end

      context 'invalid start_date' do
        it 'returns false with nil value' do
          rental = build_rental(start_date: nil)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid start_date")
        end

        it 'returns false with non-date value' do
          rental = build_rental(start_date: 'abc')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid start_date")
        end

        it 'returns false with empty value' do
          rental = build_rental(start_date: '')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid start_date")
        end
      end

      context 'invalid end_date' do
        it 'returns false with nil value' do
          rental = build_rental(end_date: nil)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid end_date")
        end

        it 'returns false with non-date value' do
          rental = build_rental(end_date: 'abc')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid end_date")
        end

        it 'returns false with empty value' do
          rental = build_rental(end_date: '')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid end_date")
        end
      end

      context 'invalid distance' do
        it 'returns false with nil value' do
          rental = build_rental(distance: nil)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid distance")
        end

        it 'returns false with negative value' do
          rental = build_rental(distance: -1)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid distance")
        end

        it 'returns false with non-integer value' do
          rental = build_rental(distance: 'abc')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid distance")
        end

        it 'returns false with zero value' do
          rental = build_rental(distance: 0)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid distance")
        end

        it 'returns false with missing value' do
          rental = build_rental(distance: nil)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid distance")
        end

        it 'returns false with empty value' do
          rental = build_rental(distance: '')
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid distance")
        end
      end

      context 'invalid rental object' do
        it 'returns false with nil value' do
          rental = build_rental(id: nil, car_id: nil, start_date: nil, end_date: nil, distance: nil)
          expect(rental.valid?).to be false
          expect(rental.errors).to include("Invalid ID", "Invalid car_id", "Invalid start_date", "Invalid end_date", "Invalid distance")
        end
      end
    end
  end
end