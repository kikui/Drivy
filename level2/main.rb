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
    (1..duration).sum do |day|
      (car['price_per_day'] * calculate_discount_percentage(day)).to_i
    end
  end

  def calculate_discount_percentage(duration)
    return 1 unless duration

    if duration > 10
      0.5
    elsif duration > 4
      0.7
    elsif duration > 1
      0.9
    else
      1
    end
  end

end

Main.new.call