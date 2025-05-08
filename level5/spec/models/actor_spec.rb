require 'spec_helper'

RSpec.describe Actor do
  describe '#initialize' do
    it 'initializes with valid attributes' do
      actor = Actor.new(who: :driver, type: :debit, amount: 1000)
      expect(actor.who).to eq(:driver)
      expect(actor.type).to eq(:debit)
      expect(actor.amount).to eq(1000)
    end

    it 'allows nil attributes' do
      actor = Actor.new
      expect(actor.who).to be_nil
      expect(actor.type).to be_nil
      expect(actor.amount).to be_nil
    end
  end

  describe '#to_h' do
    it 'returns a hash representation of the actor' do
      actor = Actor.new(who: :owner, type: :credit, amount: 2000)
      expect(actor.to_h).to eq({ who: :owner, type: :credit, amount: 2000 })
    end
  end

  describe 'constants' do
    it 'defines WHOS with expected values' do
      expect(Actor::WHOS).to eq([:driver, :owner, :insurance, :assistance, :drivy])
    end

    it 'defines TYPES with expected values' do
      expect(Actor::TYPES).to eq([:debit, :credit])
    end
  end

  describe '#valid?' do
    it 'returns true for valid actor' do
      actor = Actor.new(who: :driver, type: :debit, amount: 1000)
      expect(actor.valid?).to be_truthy
      expect(actor.errors).to be_empty
    end

    it 'return false for invalid actor' do
      actor = Actor.new(who: 'invalid', type: 'invalid', amount: 1000)
      expect(actor.valid?).to be_falsey
      expect(actor.errors).to match_array(["Actor", "Invalid who", "Invalid type"])
    end

    it 'return false for missing who' do
      actor = Actor.new(type: :debit, amount: 1000)
      expect(actor.valid?).to be_falsey
      expect(actor.errors).to match_array(["Actor", "Invalid who"])
    end

    it 'return false for missing type' do
      actor = Actor.new(who: :driver, amount: 1000)
      expect(actor.valid?).to be_falsey
      expect(actor.errors).to match_array(["Actor", "Invalid type"])
    end
  end
end