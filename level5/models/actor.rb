require_relative './concerns/validable'

class Actor
  include Validable

  WHOS = [:driver, :owner, :insurance, :assistance, :drivy]
  TYPES = [:debit, :credit]

  attr_accessor :amount
  attr_reader :who, :type

  def initialize(who: nil, type: nil, amount: nil)
    @who = who
    @type = type
    @amount = amount
  end

  def to_h
    {
      who: who,
      type: type,
      amount: amount
    }
  end

  private

  def validate
    errors << "Invalid who" unless who.is_a?(Symbol) && !who.empty? && WHOS.include?(who)
    errors << "Invalid type" unless type.is_a?(Symbol) && !type.empty? && TYPES.include?(type)
    super
  end
end