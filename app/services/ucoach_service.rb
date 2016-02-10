class UcoachService
  require 'rest-client'

  BUSINESS_LOGIC_SERVICE_AUTH_KEY = Rails.application.secrets.business_logic_service
  PROCESS_CENTRIC_SERVICE_AUTH_KEY = Rails.application.secrets.process_centric_service
  AUTHENTICATION_API = "https://ucoach-authentication-api.herokuapp.com/auth"
  BUSINESS_LOGIC_SERVICE = "https://ucoach-business-logic-service.herokuapp.com/business"
  PROCESS_CENTRIC_SERVICE = "https://ucoach-process-centric-service.herokuapp.com/process"

  def initialize(params)
    @session = params[:session]
    @method = params[:method]
    @action = params[:action]
    @data = params[:data]
    @url_params = params[:url_params] || {}
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
      register: "#{PROCESS_CENTRIC_SERVICE}/register",
      get_health_measures: "#{BUSINESS_LOGIC_SERVICE}/user/measurelist/#{ @url_params[:hm_type] || 1 }",
    }
  end

  def needs_auth?
    endpoint[@action].include?("business") || endpoint[@action].include?("process")
  end

  def service_key
    return BUSINESS_LOGIC_SERVICE_AUTH_KEY if endpoint[@action].include? "business"
    return PROCESS_CENTRIC_SERVICE_AUTH_KEY if endpoint[@action].include? "process"
  end

  def headers
    h = { content_type: :json, accept: :json }

    if needs_auth?
      h["Authorization"] = service_key
      h["User-Authorization"] = @session[:auth_token]
    end
    
    return h
  end
end