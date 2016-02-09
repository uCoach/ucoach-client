class UcoachService
  require 'rest-client'

  AUTHENTICATION_API = "https://ucoach-authentication-api.herokuapp.com/auth"
  BUSINESS_LOGIC_SERVICE = "http://127.0.1.1:5701/business"

  ENDPOINT = {
    login: "#{AUTHENTICATION_API}/login",
    get_user: "#{BUSINESS_LOGIC_SERVICE}/user"
  }

  def initialize(action, data)
    @action = action
    @data = data
  end

  def do_post
    begin
      response = RestClient.post  ENDPOINT[@action], 
                                  @data.to_json, 
                                  { accept: :json, content_type: :json }

      return JSON.parse(response.body, object_class: OpenStruct)
    rescue => e
      puts e
      return nil
    end
  end
end