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
      assert_equal  (s.round(2)).to_s, Helper.format_money(s)
    }
  end
  def test_strings_are_not_accepted                                             #using property based testing to test string inputs are not formatted
    property_of{
      Rantly { sized(30) { string } }
    }.check { |s|
      assert_raises(ArgumentError){Helper.format_money(s)}
    }
  end
  def test_money_formatter_formats_amount_and_rounds_off_to_two_decimal_places
     test_cases = {10000 => "10 000", 1000000 => "1 000 000", 1600 => "1 600", 1000.12345 => "1 000.12" }
     test_cases.each do |key,value|
       assert_equal value, Helper.format_money(key)
     end
  end
end



