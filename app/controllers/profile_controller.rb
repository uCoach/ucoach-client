class ProfileController < ApplicationController
  before_filter :verify_login
  
  def my_profile
    response = UcoachService.new(session: session, method: :get, action: :get_user).do_request
    @user = JSON.parse(response.body, object_class: OpenStruct) if response.present?
  end
end
