# test_helper.rb
ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

#require File.expand_path '../../app/controller/money_formatter_controller.rb', __FILE__
require File.expand_path '../../app/helper.rb', __FILE__