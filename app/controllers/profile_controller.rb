class ProfileController < ApplicationController
  before_filter :verify_login
  
  def my_profile
    begin
      response = RestClient.get 'https://ucoach-business-logic-service.herokuapp.com/business/user', 
                                { :Authorization => "default_authorization_key",
                                  "User-Authorization" => session[:auth_token], 
                                  accept: :json }
                           
      @user = JSON.parse(response.body, object_class: OpenStruct)
    rescue => e
    end
  end
end
