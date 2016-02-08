class HomeController < ApplicationController
  require 'rest-client'

  def index    
  end

  def login
  end

  def do_login
    # response = RestClient.post 'http://pcs.herokuapp.com/login', 
    #                             { email: params[:email], password: password[:password] }, 
    #                             { accept: :json }
    if true
      session[:auth_token] = "my_token_09497d46978bf6f32265fefb5cc52264"
      redirect_to profile_path
    else
      render :login
    end
  end
end
