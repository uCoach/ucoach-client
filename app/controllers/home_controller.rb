class HomeController < ApplicationController
  layout 'login_layout'

  def index    
  end

  def login
    redirect_to profile_path if session[:auth_token].present?
  end

  def do_login
    response_body = UcoachService.new(:login, { username: params[:email], password: params[:password] }).do_post

    if response_body.present? and response_body.token.present?
      session[:auth_token] = response_body.token
      return redirect_to profile_path
    end

    @login_error = true
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
