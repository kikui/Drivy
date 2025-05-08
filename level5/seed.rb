require 'json'
require_relative 'models/car'
require_relative 'models/option'
require_relative 'models/rental'
require_relative 'models/actor'

class Seed
  def initialize
    @hash = JSON.parse(File.read('data/input.json'))
  end

  def rentals
    @rentals ||= @hash['rentals'].map do |rental|
      Rental.new(
        id: rental["id"]&.to_i,
        car_id: rental["car_id"]&.to_i,
        start_date: rental["start_date"]&.to_s,
        end_date: rental["end_date"]&.to_s,
        distance: rental["distance"]&.to_i
      )
    end
  end

  def actors
    [
      Actor.new(who: :driver, type: :debit),
      Actor.new(who: :owner, type: :credit),
      Actor.new(who: :insurance, type: :credit),
      Actor.new(who: :assistance, type: :credit),
      Actor.new(who: :drivy, type: :credit)
    ]
  end

  def cars
    @cars ||= @hash['cars'].map do |car|
      Car.new(
        id: car["id"]&.to_i,
        price_per_day: car["price_per_day"]&.to_i,
        price_per_km: car["price_per_km"]&.to_i
      )
    end
  end

  def options
    @options ||= @hash['options'].map do |option|
      Option.new(
        id: option["id"]&.to_i,
        rental_id: option["rental_id"]&.to_i,
        type: option["type"]&.to_sym
      )
    end
  end
end