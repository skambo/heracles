# frozen_string_literal: true

require_relative '../../tests/test_helper'
require 'rantly/minitest_extensions'
require File.expand_path '../../app/helper.rb', __dir__

class HelperTest < Minitest::Test
  include Rack::Test::Methods

  def test_precision_is_applied
    assert_equal '200.4567', Helper.format_money(200.45668, precision = 4)
  end

  def test_precision_must_be_a_number
    assert_raises(TypeError) { Helper.format_money(200.45668, precision = '4') }
  end

  def test_delimiter_is_applied
    assert_equal '2,000.00', Helper.format_money(2000.00, precision = 2, delimiter = ',')
  end

  # using property based testing to test numbers less than 1000
  def test_all_numbers_less_than_1000_are_not_delimited
    property_of do
      Rantly { range(1, 999) { integer } }
    end.check do |input|
      assert_equal '%.2f' % input, Helper.format_money(input)
    end
  end

  # using property based testing to test numbers less than 1000
  def test_all_numbers_greater_than_1000_are_delimited
    property_of do
      Rantly { range(1000, 9999) { integer } }
    end.check do |input|
      expected_string = '%.2f' % input
      expected_string = expected_string.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\\1 ')
      assert_equal expected_string, Helper.format_money(input)
    end
  end

  # using property based testing to test numbers less than 1000 with decimal places
  #
  def test_float_numbers_less_than_1000_are_rounded_off_and_not_delimited
    property_of do
      Rantly { range(1, 999.00) { float } }
    end.check do |input|
      assert_equal '%.2f' % input, Helper.format_money(input)
    end
  end

  # using property based testing to test numbers less than 1000 with decimal places
  def test_float_numbers_greater_than_1000_are_delimited
    property_of do
      Rantly { range(1000.00, 9999.00) { float } }
    end.check do |input|
      expected_string = '%.2f' % input
      expected_string = expected_string.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\\1 ')
      assert_equal expected_string, Helper.format_money(input)
    end
  end

  # using property based testing to test string inputs are not formatted
  def test_strings_are_not_accepted
    property_of do
      Rantly { sized(30) { string } }
    end.check do |input|
      assert_raises(TypeError) { Helper.format_money(input) }
    end
  end
end
