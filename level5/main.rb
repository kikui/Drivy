require 'json'
require 'date'
require_relative 'rental_calculator'

class Main
  def initialize
    hash = JSON.parse(File.read('data/input.json'))
    @cars = hash['cars']
    @rentals = hash['rentals']
    @options = hash['options']
    @output_data = []
  end

  def call
    @rentals.each do |rental|
      car = @cars.find { |c| c['id'] == rental['car_id'] }
      next unless car

      rental_options = @options.select { |option| option['rental_id'] == rental['id'] }
      @output_data << { 
        id: rental['id'],
        options: rental_options.map { |option| option['type'] },
        actions: generate_actors_actions(RentalCalculator.new(rental, car, rental_options))
      }
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
        amount: rental_calculator.driver_price
      },
      {
        who: 'owner',
        type: 'credit',
        amount: rental_calculator.owner_price
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