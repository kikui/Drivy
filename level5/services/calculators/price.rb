module Calculators
  class Price
    DISCOUNT_50 = 0.5
    DISCOUNT_30 = 0.7
    DISCOUNT_10 = 0.9

    GPS_OPTION_PRICE = 500
    BABY_SEAT_OPTION_PRICE = 200
    ADDITIONAL_INSURANCE_OPTION_PRICE = 1000

    attr_reader :rental, :car, :options

    def initialize(rental:, car: , options: [])
      @rental = rental
      @car = car
      @options = options
    end

    def price(with_distance: true, with_time: true, with_options: true, option_types: [])
      options_price = with_options ? price_by_options(option_types) : 0
      distance_price = with_distance ? price_by_distance : 0
      time_price = with_time ? price_by_time : 0

      (options_price + distance_price + time_price).to_i
    end

    private

    def price_by_options(option_types)
      options
        .select { |option| option_types.include?(option.type) }
        .inject(0) { |total, option| total + option_price(option) }
    end

    def price_by_distance
      rental.distance * car.price_per_km
    end

    def price_by_time
      (1..rental.duration).sum do |day|
        (car.price_per_day * time_discount_percentage(day)).to_i
      end
    end

    def time_discount_percentage(day)
      if day > 10
        DISCOUNT_50
      elsif day > 4
        DISCOUNT_30
      elsif day > 1
        DISCOUNT_10
      else
        1
      end
    end

    def option_price(option)
      case option.type
      when :gps
        rental.duration * GPS_OPTION_PRICE
      when :baby_seat
        rental.duration * BABY_SEAT_OPTION_PRICE
      when :additional_insurance
        rental.duration * ADDITIONAL_INSURANCE_OPTION_PRICE
      else
        0
      end
    end
  end
end