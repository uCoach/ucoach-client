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
    @message = session[:message]
    session[:message] = nil
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
    puts "response: " + response
    
    if response.present?
      response_body = JSON.parse response, object_class: OpenStruct
      session[:message] = response_body.message

      if response_body.achievedGoals.empty?
        return redirect_to health_measures_path(hm_type: params[:hm_type_id])
      else
        return redirect_to goals_path
      end
    end

    @error = true
    response = UcoachService.new(session: session, method: :get, action: :get_health_measures, url_params: params).do_request
    @health_measures = JSON.parse(response.body, object_class: OpenStruct) if response.present?

    render :my_health_measures
  end

  def my_goals
    @message = session[:message]
    session[:message] = nil
    response = UcoachService.new(session: session, method: :get, action: :get_goals, url_params: params).do_request
    @goals = JSON.parse(response.body, object_class: OpenStruct) if response.present?
  end

  def create_goal
    new_goal = {
      measureType: params[:hm_type_id],
      value: params[:value],
      objective: params[:objective],
      frequency: params[:frequency],
      createdDate: Date.today.to_s,
      dueDate: params[:due_date]
    }
    # new_goal[:dueDate] = params[:due_date] || Date.today.to_s
    
    response = UcoachService.new(session: session, method: :post, action: :new_goal, data: new_goal).do_request

    if response.present?
      return redirect_to goals_path
    end

    @error = true
    response = UcoachService.new(session: session, method: :get, action: :get_goals, url_params: params).do_request
    @goals = JSON.parse(response.body, object_class: OpenStruct) if response.present?
    render :my_goals
  end
end
