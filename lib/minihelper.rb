require 'pry'
require 'minihelper/version'

# default module
module Minihelper
  class Error < StandardError; end

  # Your code goes here...
  def parse_money_to_float(money)
    return -1 unless valid_money?(money)

    money_result = standardizes_money_input(money)

    return money_result.to_f unless part_decimal?(money_result)
    return money_result.tr('.', '').to_f if ends_with_thousand?(money_result)

    money_parts = money_result.split('.')
    integer_part = money_parts[0..-2].join('')
    decimal_part = money_parts[-1]

    [integer_part, decimal_part].join('.').to_f
  end

  def standardizes_money_input(money)
    money.tr('R$ ', '').tr(',', '.')
  end

  def ends_with_thousand?(money)
    money.split('.')[-1].length == 3
  end

  def part_decimal?(money)
    money.match(/\./)
  end

  def valid_money?(money)
    return false if money.nil?
    return false if money.gsub(/\s+/, '').empty?
    return false if money.match(/\d/).nil?

    true
  end
end
