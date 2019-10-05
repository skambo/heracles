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