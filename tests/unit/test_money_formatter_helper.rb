require_relative '../../tests/test_helper'
require 'rantly/minitest_extensions'
require File.expand_path '../../../app/helper.rb', __FILE__

class HelperTest < Minitest::Test

  include Rack::Test::Methods


  def test_precision_is_applied
    assert_equal "200.4567", Helper.format_money(200.45668, precision = 4)
  end

  def test_precision_must_be_a_number
    assert_raises(TypeError){ Helper.format_money(200.45668, precision = "4")}
  end

  def test_delimiter_is_applied
    assert_equal "2,000.00", Helper.format_money(2000.00, precision = 2, delimiter = ",")
  end

  def test_all_numbers_less_than_1000_are_not_delimited                           #using property based testing to test numbers less than 1000
    property_of{
      Rantly { range(1,999) { integer } }
    }.check { |input|
      assert_equal "%.2f" % input, Helper.format_money(input)
    }
  end

  def test_float_numbers_less_than_1000_are_rounded_off_and_not_delimited      #using property based testing to test numbers less than 1000 with decimal places
    property_of{
      Rantly { range(1,999.00) { float } }
    }.check { |input|
      assert_equal "%.2f" % input, Helper.format_money(input)
    }
  end

  def test_strings_are_not_accepted                                             #using property based testing to test string inputs are not formatted
    property_of{
      Rantly { sized(30) { string } }
    }.check { |input|
      assert_raises(TypeError){Helper.format_money(input)}
    }
  end
end