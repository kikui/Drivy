class RentalCalculator
  DRIVY_COMMISSION = 0.3
  INSURANCE_FEE = 0.5
  ASSISTANCE_FEE = 100

  def initialize(rental, car)
    @rental = rental
    @car = car
  end

  def price
    @price ||= (price_by_distance + price_by_time).to_i
  end

  def insurance_fee
    @insurance_fee ||= (commission * INSURANCE_FEE).to_i
  end

  def assistance_fee
    @assistance_fee ||= (duration * ASSISTANCE_FEE).to_i
  end

  def drivy_fee
    @drivy_fee ||= (commission - insurance_fee - assistance_fee).to_i
  end

  private

  def duration
    @duration ||= (Date.parse(@rental['end_date']) - Date.parse(@rental['start_date'])).to_i + 1 || 0
  end

  def commission
    @comission ||= price * DRIVY_COMMISSION
  end

  def price_by_distance
    distance = @rental['distance'].to_i || 0
    price_per_km = @car['price_per_km'].to_i || 0
    distance * price_per_km
  end

  def price_by_time
    (1..duration).sum do |day|
      (@car['price_per_day'] * discount_percentage(day)).to_i
    end
  end

  def discount_percentage(day)
    return 1 unless day

    if day > 10
      0.5
    elsif day > 4
      0.7
    elsif day > 1
      0.9
    else
      1
    end
  end
end