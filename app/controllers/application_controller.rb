class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :add_ip_address

  private

  def add_ip_address
    gon.endpoint = Rails.configuration.hue_api_endpoint
  end
end
