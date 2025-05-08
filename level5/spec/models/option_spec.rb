require 'spec_helper'

RSpec.describe Option do
  describe '#initialize' do
    it 'initializes with valid attributes' do
      option = Option.new(id: 1, rental_id: 2, type: :gps)
      expect(option.id).to eq(1)
      expect(option.rental_id).to eq(2)
      expect(option.type).to eq(:gps)
    end
  end

  describe '#valid?' do
    context 'with valid attributes' do
      it 'returns true' do
        option = Option.new(id: 1, rental_id: 2, type: :gps)
        expect(option.valid?).to be true
      end
    end

    context 'with invalid attributes' do
      context 'invalid id' do
        it 'returns false for nil id' do
          option = Option.new(id: nil, rental_id: 2, type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid ID")
        end

        it 'returns false for negative id' do
          option = Option.new(id: -1, rental_id: 2, type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid ID")
        end

        it 'returns false for non-integer id' do
          option = Option.new(id: 'a', rental_id: 2, type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid ID")
        end

        it 'returns false for missing id' do
          option = Option.new(rental_id: 2, type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid ID")
        end

        it 'returns false for zero id' do
          option = Option.new(id: 0, rental_id: 2, type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid ID")
        end
      end

      context 'invalid rental_id' do
        it 'returns false for nil rental_id' do
          option = Option.new(id: 1, rental_id: nil, type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid rental_id")
        end

        it 'returns false for negative rental_id' do
          option = Option.new(id: 1, rental_id: -2, type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid rental_id")
        end

        it 'returns false for non-integer rental_id' do
          option = Option.new(id: 1, rental_id: 'b', type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid rental_id")
        end

        it 'returns false for missing rental_id' do
          option = Option.new(id: 1, type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid rental_id")
        end

        it 'returns false for zero rental_id' do
          option = Option.new(id: 1, rental_id: 0, type: :gps)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid rental_id")
        end
      end

      context 'invalid type' do
        it 'returns false for nil type' do
          option = Option.new(id: 1, rental_id: 2, type: nil)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid type")
        end

        it 'returns false for non-symbol type' do
          option = Option.new(id: 1, rental_id: 2, type: 'gps')
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid type")
        end

        it 'returns false for invalid type' do
          option = Option.new(id: 1, rental_id: 2, type: :invalid_type)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid type")
        end

        it 'returns false for missing type' do
          option = Option.new(id: 1, rental_id: 2)
          expect(option.valid?).to be false
          expect(option.errors).to include("Invalid type")
        end
      end
    end
  end
end