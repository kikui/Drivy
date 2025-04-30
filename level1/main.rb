require 'json'
require 'date'

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

      @output_data << { id: rental['id'], price: calculate_price(car, rental) }
    end

    File.write('./data/output.json', JSON.pretty_generate({
      rentals: @output_data
    }))
  end

  private

  def calculate_price(car, rental)
    price_by_distance(car, rental) + price_by_time(car, rental)
  end

  def price_by_distance(car, rental)
    distance = rental['distance'].to_i || 0
    price_per_km = car['price_per_km'].to_i || 0
    distance * price_per_km
  end

  def price_by_time(car, rental)
    duration = (Date.parse(rental['end_date']) - Date.parse(rental['start_date'])).to_i + 1 || 0
    price_per_day = car['price_per_day'].to_i || 0
    duration * price_per_day
  end
end

Main.new.call