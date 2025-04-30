require 'json'
require 'date'
require_relative 'rental_calculator'

class Main
  def initialize
    hash = JSON.parse(File.read('data/input.json'))
    @cars = hash['cars']
    @rentals = hash['rentals']
    @output_data = []
  end

  def call
    @rentals.each do |rental|
      car = @cars.find { |c| c['id'] == rental['car_id'] }
      next unless car

      @output_data << { id: rental['id'], actions: generate_actors_actions(RentalCalculator.new(rental, car)) }
    end

    File.write('./data/output.json', JSON.pretty_generate({
      rentals: @output_data
    }))
  end

  private

  def generate_actors_actions(rental_calculator)
    [
      {
        who: 'driver',
        type: 'debit',
        amount: rental_calculator.price
      },
      {
        who: 'owner',
        type: 'credit',
        amount: rental_calculator.price - rental_calculator.insurance_fee - rental_calculator.assistance_fee - rental_calculator.drivy_fee
      },
      {
        who: 'insurance',
        type: 'credit',
        amount: rental_calculator.insurance_fee
      },
      {
        who: 'assistance',
        type: 'credit',
        amount: rental_calculator.assistance_fee
      },
      {
        who: 'drivy',
        type: 'credit',
        amount: rental_calculator.drivy_fee
      }
    ]
  end
end

Main.new.call