class RentalCalculator
  DRIVY_COMMISSION = 0.3
  INSURANCE_PERCENTAGE_FEE = 0.5
  ASSISTANCE_PRICE_FEE = 100

  GPS_OPTION_PRICE = 500
  BABY_SEAT_OPTION_PRICE = 200
  ADDITIONAL_INSURANCE_OPTION_PRICE = 1000

  DISCOUNT_50 = 0.5
  DISCOUNT_30 = 0.7
  DISCOUNT_10 = 0.9

  def initialize(rental, car, options)
    @rental = rental
    @car = car
    @options = options
  end

  def driver_price
    @driver_price ||= (price_without_options + price_by_options(["gps", "baby_seat", "additional_insurance"])).to_i
  end

  def owner_price
    @owner_price ||= (price_without_options - commission + price_by_options(["gps", "baby_seat"])).to_i
  end

  def insurance_fee
    @insurance_fee ||= (commission * INSURANCE_PERCENTAGE_FEE).to_i
  end

  def assistance_fee
    @assistance_fee ||= (duration * ASSISTANCE_PRICE_FEE).to_i
  end

  def drivy_fee
    @drivy_fee ||= (commission - insurance_fee - assistance_fee + price_by_options(["additional_insurance"])).to_i
  end

  private

  def duration
    @duration ||= (Date.parse(@rental["end_date"]) - Date.parse(@rental["start_date"])).to_i + 1 || 0
  end

  def price_without_options
    @price_without_options ||= (price_by_distance + price_by_time)
  end

  def commission
    @comission ||= price_without_options * DRIVY_COMMISSION
  end

  def price_by_distance
    distance = @rental["distance"].to_i || 0
    price_per_km = @car["price_per_km"].to_i || 0
    distance * price_per_km
  end

  def price_by_time
    price_per_day = @car["price_per_day"].to_i || 0
    duration * price_per_day * discount_percentage
  end

  def discount_percentage
    return 1 unless duration

    if duration > 10
      DISCOUNT_50
    elsif duration > 4
      DISCOUNT_30
    elsif duration > 1
      DISCOUNT_10
    else
      1
    end
  end

  def price_by_options(option_types)
    @options
      .select { |option| option_types.include?(option["type"]) }
      .inject(0) { |total, option| total + option_price(option) }
  end

  def option_price(option)
    return 0 unless option

    case option["type"]
    when "gps"
      duration * GPS_OPTION_PRICE
    when "baby_seat"
      duration * BABY_SEAT_OPTION_PRICE
    when "additional_insurance"
      duration * ADDITIONAL_INSURANCE_OPTION_PRICE
    else
      0
    end
  end
end