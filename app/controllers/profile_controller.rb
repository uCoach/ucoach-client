class ProfileController < ApplicationController
  before_filter :verify_login
  
  require 'rest-client'
  def my_profile
    response = RestClient.get 'http://127.0.1.1:4000/persons/1', { accept: :json }
    @user = JSON.parse(response.body, object_class: OpenStruct)
  end
end
