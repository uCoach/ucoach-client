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

  def create_health_measure
    new_health_measure = {
      typeId: params[:hm_type_id],
      value: params[:value]
    }

    response = UcoachService.new(session: session, method: :post, action: :new_health_measure, data: new_health_measure).do_request
    
    # "{\"message\":\"Keep going! Almost there\",\"status\":200,\"achievedGoals\":[]}"

    if response.present?
      return redirect_to health_measures_path(hm_type: params[:hm_type_id])
    end

    @error = true
    response = UcoachService.new(session: session, method: :get, action: :get_health_measures, url_params: params).do_request
    @health_measures = JSON.parse(response.body, object_class: OpenStruct) if response.present?

    render :my_health_measures
  end

  def my_goals
    response = UcoachService.new(session: session, method: :get, action: :get_goals, url_params: params).do_request
    @goals = JSON.parse(response.body, object_class: OpenStruct) if response.present?
  end
end
