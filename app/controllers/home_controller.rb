class HomeController < ApplicationController
  layout 'login_layout'
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

  def register
  end

  def do_register
    if true
      session[:auth_token] = "my_token_09497d46978bf6f32265fefb5cc52264"
      redirect_to profile_path
    else
      render :register
    end
  end
end
