require_relative '../../tests/test_helper'
require 'rantly/minitest_extensions' # for 'minitest'

class HelperTest < Minitest::Test

  include Rack::Test::Methods


  def test_all_numbers_less_than_1000_are_not_formatted                           #using property based testing to test numbers less than 1000
    property_of{
      Rantly { range(1,999) { integer } }
    }.check { |s|
      assert_equal s.to_s, Helper.format_money(s)
    }
  end
  def test_float_numbers_less_than_1000_are_rounded_off_and_not_formatted        #using property based testing to test numbers less than 1000 with decimal places
    property_of{
      Rantly { range(1,999.00) { float } }
    }.check { |s|
      assert_equal (s.round(2)).to_s, Helper.format_money(s)
    }
  end
  def test_strings_are_not_accepted                                             #using property based testing to test string inputs are not formatted
    property_of{
      Rantly { sized(30) { string } }
    }.check { |s|
      assert_raises(ArgumentError){Helper.format_money(s)}
    }
  end
  def test_money_formatter
    skip
    assert_equal "89 000", Helper.format_money(89000)
  end

  def test_money_formatter_spaces
    skip
    assert_equal "89000", Helper.format_money(89000)
  end
  def test_negatives_not_allowed
    skip
    assert_equal " Negative number not allowed" , Helper.format_money("- 89 000")
  end
  def test_strings_not_allowed
    skip
  assert_equal " Enter a figure" , Helper.format_money("twenty")
  end
  def test_more_than_five_decimals
    skip
  assert_equal "89.12" , Helper.format_money(89.123456)
  end
  def test_special_chars_not_allowed
    skip
    assert_equal "890 000" , Helper.format_money("KSH 890000")
  end
end



