class UcoachService
  require 'rest-client'

  BUSINESS_LOGIC_SERVICE_AUTH_KEY = Rails.application.secrets.business_logic_service
  AUTHENTICATION_API = "https://ucoach-authentication-api.herokuapp.com/auth"
  BUSINESS_LOGIC_SERVICE = "https://ucoach-business-logic-service.herokuapp.com/business"

  ENDPOINT = {
    login: "#{AUTHENTICATION_API}/login",
    get_user: "#{BUSINESS_LOGIC_SERVICE}/user"
  }

  def initialize(session, method, action, data)
    @session = session
    @method = method
    @action = action
    @data = data
  end

  def do_request
    begin
      return RestClient::Request.execute(
                                  method: @method,
                                  url: ENDPOINT[@action], 
                                  payload: @data.to_json, 
                                  headers: headers
                                )
    rescue => e
      puts e
      return nil
    end
  end

  def business_logic_request?
    ENDPOINT[@action].include? "business"
  end

  def headers
    h = { content_type: :json, accept: :json }

    if business_logic_request?
      h["Authorization"] = BUSINESS_LOGIC_SERVICE_AUTH_KEY
      h["User-Authorization"] = @session[:auth_token]
    end

    return h
  end
end