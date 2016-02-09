class ProfileController < ApplicationController
  before_filter :verify_login
  
  def my_profile
    response = UcoachService.new(session: session, method: :get, action: :get_user).do_request
    @user = JSON.parse(response.body, object_class: OpenStruct) if response.present?
  end

  def google_authorization
    # response = UcoachService.new(session: session, method: :get, action: :google_auth).do_request
    # if response.present?
    #   response_body = JSON.parse response, object_class: OpenStruct
    #   return redirect_to response_body.location
    # end
    redirect_to profile_path
  end
end
