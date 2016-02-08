class HomeController < ApplicationController
  require 'rest-client'
  def index    
  end

  def login
  end

  def do_login
    response = RestClient.get 'http://127.0.1.1:4000/persons/1', { accept: :json }
    @person = JSON.parse(response.body, object_class: Struct)
    render :login
  end
end
