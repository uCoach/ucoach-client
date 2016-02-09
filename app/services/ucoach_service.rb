class UcoachService
  require 'rest-client'

  BUSINESS_LOGIC_SERVICE_AUTH_KEY = Rails.application.secrets.business_logic_service
  AUTHENTICATION_API = "https://ucoach-authentication-api.herokuapp.com/auth"
  BUSINESS_LOGIC_SERVICE = "https://ucoach-business-logic-service.herokuapp.com/business"
  PROCESS_CENTRIC_SERVICE = "pending"

  def initialize(params)
    @session = params[:session]
    @method = params[:method]
    @action = params[:action]
    @data = params[:data]
  end

  def do_request
    begin
      return RestClient::Request.execute(
                                  method: @method,
                                  url: endpoint[@action], 
                                  payload: @data.to_json, 
                                  headers: headers
                                )
    rescue => e
      puts e
      return nil
    end
  end

  def endpoint
    {
      login: "#{AUTHENTICATION_API}/login",
      logout: "#{AUTHENTICATION_API}/logout/#{@session[:auth_token]}",
      get_user: "#{BUSINESS_LOGIC_SERVICE}/user",
      google_auth: "#{BUSINESS_LOGIC_SERVICE}/user/google/authorization",
      register: "#{PROCESS_CENTRIC_SERVICE}/"
    }
  end

  def business_logic_request?
    endpoint[@action].include? "business"
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