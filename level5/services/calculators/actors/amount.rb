require_relative '../price'
require_relative '../commission'

module Calculators
  module Actors
    class Amount
      attr_reader :price_calculator, :commission_calculator, :actor

      def initialize(actor:, rental:, car:, options: [])
        @actor = actor
        @price_calculator = Calculators::Price.new(rental: rental, car: car, options: options)
        @commission_calculator = Calculators::Commission.new(rental.duration, price_calculator)
      end

      def call
        case actor.who
        when :driver
          price_calculator.price(option_types: [:gps, :baby_seat, :additional_insurance])
        when :owner
          price_calculator.price(option_types: [:gps, :baby_seat]) - commission_calculator.commission
        when :insurance
          commission_calculator.insurance_fee
        when :assistance
          commission_calculator.assistance_fee
        when :drivy
          commission_calculator.drivy_fee
        else
          raise ArgumentError, "#{self.class} - Invalid actor"
        end
      end
    end
  end
end