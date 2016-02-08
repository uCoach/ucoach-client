class HomeController < ApplicationController
  layout 'login_layout'
  require 'rest-client'

  def index    
  end

  def login
  end

  def do_login
    # response = RestClient.post 'http://pcs.herokuapp.com/login', 
    #                             { email: params[:email], password: params[:password] }, 
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
    # response = RestClient.post 'http://127.0.1.1:4000/persons/', 
    #                             { firstname: params[:firstname], lastname: params[:lastname] }.to_json, 
    #                             { accept: :json, content_type: :json }

    if true
      session[:auth_token] = "my_token_09497d46978bf6f32265fefb5cc52264"
      redirect_to profile_path
    else
      render :register
    end
  end

  def logout
    session[:auth_token] = nil
    redirect_to root_path
  end
end
