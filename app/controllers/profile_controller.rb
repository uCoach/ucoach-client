class ProfileController < ApplicationController
  before_filter :verify_login
  
  require 'rest-client'
  def my_profile
    response = RestClient.get 'http://127.0.1.1:5701/business/user', 
                              { :Authorization => "default_authorization_key",
                                "User-Authorization" => session[:auth_token], 
                                accept: :json }
                         
    @user = JSON.parse(response.body, object_class: OpenStruct)
  end
end
