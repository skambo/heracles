require_relative '../../app/controller/money_formatter_controller'
require_relative '../../tests/test_helper'

class MoneyFormatterControllerTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  def app
    MoneyFormatterController
  end

# we post to the controller, which invokes our helper and the helper formats the money
  def test_integration_between_helper_and_controller
    post '/api/v1/formatAmount', params = { amount: '10000' }
    assert last_response.ok?
    assert last_response.body.include?("10 000")
  end

  def test_controller_does_not_accept_empty_input
    post '/format', params = {:amount => ""}
    assert last_response.ok?
    assert last_response.body.include?("Please enter valid input")
  end

  def test_controller_does_not_accept_strings
  post '/format', params = {:amount => "twenty thousand"}
  assert last_response.ok?
  assert last_response.body.include?("Please enter valid input")
end
end