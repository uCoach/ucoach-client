class HomeController < ApplicationController
  layout 'login_layout'
  require 'rest-client'

  def index    
  end

  def login
    redirect_to profile_path if session[:auth_token].present?
  end

  def do_login
    begin
      response = RestClient.post 'https://ucoach-authentication-api.herokuapp.com/auth/login', 
                                  { username: params[:email], password: params[:password] }.to_json, 
                                  { accept: :json, content_type: :json }

      response_body = JSON.parse(response.body, object_class: OpenStruct)

      if response_body.token.present?
        session[:auth_token] = response_body.token
        return redirect_to profile_path
      end

    rescue => e
      @login_error = true
    end

    render :login
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
