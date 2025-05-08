require 'json'
require_relative 'seed'
require_relative 'services/calculators/actors/amount'

class Main
  attr_reader :seed

  def initialize 
    @seed = Seed.new
  end

  def call
    output_data = []
    seed.rentals.each do |rental|
      raise StandardError, rental.errors unless rental.valid?

      car = seed.cars.find { |car| car.id == rental.car_id }
      raise StandardError, car.errors unless car.valid?

      options = seed.options.select { |option| option.rental_id == rental.id }
      raise StandardError, options.map(&:errors).join(", ") unless options.all?(&:valid?)

      output_data << {
        id: rental.id,
        options: options.map { |option| option.type },
        actions: seed.actors
          .each {  |actor| actor.amount = ::Calculators::Actors::Amount.new(rental: rental, car: car, options: options, actor: actor).call }
          .map { |actor| actor.to_h }
      }
    end

    File.write('./data/output.json', JSON.pretty_generate({
      rentals: output_data
    }))
  rescue StandardError => error
    puts error.message
  end
end

Main.new.call