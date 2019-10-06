# frozen_string_literal: true

require_relative '../../app/helper'
require 'rack-flash'
require 'sinatra'

class MoneyFormatterController < Sinatra::Base
  use Rack::Flash

  configure do # configure method tells Sinatra where to find views
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do                                              # get method displays the form
    erb :index
  end

  post '/api/v1/formatAmount' do                          # post method receives input from the user, and does the validation and returns the formatted amount back to the user
    amount = params[:amount]
    if amount.empty? || !Helper.is_number?(amount)
      flash[:message] = 'Please enter valid input'
      erb :formatted
    else
      @formatted_amount = Helper.format_money(amount.to_f)
      erb :formatted
    end
  end
end
