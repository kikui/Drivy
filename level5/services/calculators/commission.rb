module Calculators
  class Commission
    DRIVY_COMMISSION = 0.3
    INSURANCE_PERCENTAGE_FEE = 0.5
    ASSISTANCE_PRICE_FEE = 100

    attr_reader :duration, :price_calculator

    def initialize(rental_duration, price_calculator_instance)
      @duration = rental_duration
      @price_calculator = price_calculator_instance
    end
    
    def insurance_fee
      @insurance_fee ||= (commission * INSURANCE_PERCENTAGE_FEE).to_i
    end

    def assistance_fee
      @assistance_fee ||= (duration * ASSISTANCE_PRICE_FEE).to_i
    end

    def drivy_fee
      @drivy_fee ||= (commission - insurance_fee - assistance_fee + price_calculator.price(with_distance: false, with_time: false, option_types: [:additional_insurance])).to_i
    end

    def commission
      @comission ||= (price_calculator.price(with_options: false) * DRIVY_COMMISSION).to_i
    end
  end
end