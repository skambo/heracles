class Helper

  def self.format_money(amount, precision = 2, delimiter = " ")
    unless is_number?(amount)
      raise ArgumentError
    end
    amount = amount.round(precision)                          #applying precision which rounds off
    amount_string = "%.#{precision}f" % amount
    amount_string.gsub(/(\d)(?=(\d\d\d)+(?!\d)).$/, "\\1#{delimiter}")
  end

  def self.is_number?(string)
    true if Float(string) rescue false
  end
end
