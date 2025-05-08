require 'json'
require 'date'

class Main
  DRIVY_COMMISSION = 0.3
  INSURANCE_FEE = 0.5
  ASSISTANCE_FEE = 100

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

      rentral_price = calculate_price(car, rental)
      commissions = calculate_commission(rentral_price, rental)
      @output_data << { id: rental['id'], price: rentral_price, commission: commissions }
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

  def calculate_commission(price, rental)
    duration = (Date.parse(rental['end_date']) - Date.parse(rental['start_date'])).to_i + 1 || 0
    commission = price * DRIVY_COMMISSION
    insurance_fee = commission * INSURANCE_FEE
    assistance_fee = duration * ASSISTANCE_FEE
    drivy_fee = commission - insurance_fee - assistance_fee

    {
      insurance_fee: insurance_fee.to_i,
      assistance_fee: assistance_fee.to_i,
      drivy_fee: drivy_fee.to_i
    }
  end

end

Main.new.call