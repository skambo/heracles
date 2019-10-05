require_relative '../../app/helper'

class MoneyFormatterController < Sinatra::Base

    configure do                            #configure method tells Sinatra where to find views
      set :views, 'app/views'
    end

    get "/" do                              #get method displays the form
        erb :index
    end

    post "/format" do                       #post method receives input from the user, and does the validation and returns the formatted amount back to the user
        amount = params[:amount]
        @formatted_amount = Helper.format_money(amount)
        erb :formatted
    end
end
