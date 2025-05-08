require 'spec_helper'

RSpec.describe Validable do
  let(:dummy_class) { ValidableClass }

  let(:instance) { dummy_class.new }

  describe '#valid?' do
    context 'when there are no validation errors' do
      it 'returns true' do
        expect(instance.valid?).to be true
      end
    end

    context 'when there are validation errors' do
      it 'returns false' do
        instance.invalidate!
        expect(instance.valid?).to be false
      end
    end

    context 'when an ArgumentError is raised during validation' do
      it 'returns false' do
        allow(instance).to receive(:validate).and_raise(ArgumentError)
        expect(instance.valid?).to be false
      end
    end
  end

  describe '#errors' do
    it 'returns an empty array by default' do
      expect(instance.errors).to eq([])
    end

    it 'accumulates validation errors' do
      instance.invalidate!
      instance.valid?
      expect(instance.errors).to include('Invalid')
    end
  end
end