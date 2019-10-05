class Helper
  def self.format_money(amount)
    unless amount.class.superclass == Numeric
      raise ArgumentError
    end
    amount = amount.round(2)
    amount.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1 ")
  end
end