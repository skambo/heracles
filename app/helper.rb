# frozen_string_literal: true

class Helper
  def self.format_money(amount, precision = 2, delimiter = ' ')
    raise TypeError unless is_number?(amount)

    raise TypeError unless is_number?(precision)

    rounded_amount = "%.#{precision}f" % amount.round(precision)
    amount_string = rounded_amount.split('.')
    amount_string[0].gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1#{delimiter}") + '.' + amount_string[1]
  end

  def self.is_number?(string)
    true if Float(string)
  rescue StandardError
    false
  end
end
