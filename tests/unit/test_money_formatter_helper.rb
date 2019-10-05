require_relative '../../tests/test_helper'

class HelperTest < Minitest::Test

  include Rack::Test::Methods

  def test_money_formatter
    assert_equal "89 000", Helper.format_money(89000)
  end

  def test_money_formatter_spaces
    assert_equal "89000", Helper.format_money(89000)
  end
  def test_negatives_not_allowed
    assert_equal " Negative number not allowed" , Helper.format_money("- 89 000")
  end
  def test_strings_not_allowed
  assert_equal " Enter a figure" , Helper.format_money("twenty")
  end
  def test_more_than_five_decimals
  assert_equal "89.12" , Helper.format_money(89.123456)
  end
  def test_special_chars_not_allowed
    assert_equal "890 000" , Helper.format_money("KSH 890000")
  end
end



