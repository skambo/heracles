#The helper class receives an amount, and converts it using defaults to cater for spaces and
# rounding off. We use the gsub method with a regex to format the input given. The helper also checks if amount given is a number

class Helper
  def self.format_money(amount)
    unless is_number?(amount)
      raise ArgumentError
    end
    amount = amount.round(2)
    amount.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")
  end
  def self.is_number?(string)
    true if Float(string) rescue false
  end
end