require_relative './concerns/validable'
require 'date'

class Rental
  include Validable

  attr_reader :id, :car_id, :start_date, :end_date, :distance

  def initialize(id:, car_id:, start_date:, end_date:, distance:)
    @id = id
    @car_id = car_id
    @start_date = Date.parse(start_date) rescue nil
    @end_date = Date.parse(end_date) rescue nil
    @distance = distance
  end

  def duration
    @duration ||= (end_date - start_date + 1).to_i
  end

  private

  def validate
    errors << "Invalid ID" unless id.is_a?(Integer) && id > 0
    errors << "Invalid car_id" unless car_id.is_a?(Integer) && car_id > 0
    errors << "Invalid start_date" unless start_date.is_a?(Date)
    errors << "Invalid end_date" unless end_date.is_a?(Date)
    errors << "Invalid distance" unless distance.is_a?(Integer) && distance > 0
    super
  end
end