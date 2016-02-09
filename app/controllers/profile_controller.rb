class ProfileController < ApplicationController
  before_filter :verify_login
  
  def my_profile
    response = UcoachService.new(session, :get, :get_user, nil).do_request
    @user = JSON.parse(response.body, object_class: OpenStruct) if response.present?
  end
end
