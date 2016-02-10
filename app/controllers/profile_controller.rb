class ProfileController < ApplicationController
  before_filter :verify_login
  
  def my_profile
    if params[:google_state].present? and params[:google_state] == "true"
      session[:google_connection] = true
    end

    response = UcoachService.new(session: session, method: :get, action: :get_user).do_request
    @user = JSON.parse(response.body, object_class: OpenStruct) if response.present?
  end

  def google_authorization
    response = UcoachService.new(session: session, method: :get, action: :google_auth).do_request
    if response.present?
      response_body = JSON.parse response, object_class: OpenStruct
      return redirect_to response_body.location
    end
    redirect_to profile_path
  end

  def my_health_measures
    response = UcoachService.new(session: session, method: :get, action: :get_health_measures, url_params: params).do_request
    @health_measures = JSON.parse(response.body, object_class: OpenStruct) if response.present?
  end
end
