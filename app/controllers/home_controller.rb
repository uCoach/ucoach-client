class HomeController < ApplicationController
  layout 'login_layout'

  def login
    redirect_to profile_path if session[:auth_token].present?
  end

  def do_login
    login_info = { username: params[:email], password: params[:password] }

    response = UcoachService.new(session: session, method: :post, action: :login, data: login_info).do_request
    response_body = JSON.parse(response.body, object_class: OpenStruct) if response.present?

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
    new_user = {
      firstname: params[:firstname],
      lastname: params[:lastname],
      email: params[:email],
      birthdate: params[:birthdate],
      password: params[:password],
      twitterUsername: params[:twitter_username].gsub("@", "")
    }

    # response = UcoachService.new(session: session, method: :post, action: :register, data: new_user).do_request
    # response_body = JSON.parse(response.body, object_class: OpenStruct) if response.present?

    # if response_body.present? and response_body.token.present?
    #   session[:auth_token] = response_body.token
    #   return redirect_to profile_path
    # end
    render :register
  end

  def logout
    UcoachService.new(session: session, method: :get, action: :logout).do_request
    session[:auth_token] = nil
    redirect_to root_path
  end
end
