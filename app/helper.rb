class Helper

  def self.format_money(amount, precision = 2, delimiter = " ")
    unless is_number?(amount)
      raise TypeError
    end

    unless is_number?(precision)
      raise TypeError
    end

    rounded_amount = "%.#{precision}f" % amount.round(precision)
    amount_string = rounded_amount.split('.')
    amount_string[0].gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1#{delimiter}") + "." + amount_string[1]
  end

  def self.is_number?(string)
    true if Float(string) rescue false
  end
end
