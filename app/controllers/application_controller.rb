class ApplicationController < ActionController::Base
  respond_to :html, :json
  include ActionView::Helpers::SanitizeHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :resource_name, :resource, :devise_mapping, :affix_header?

  before_action :set_flash

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def affix_header?
    controller_name == 'home'
  end

  def set_flash
    params[:flash].each do |type, message|
      flash[type.to_sym] = sanitize(message[0..255])
    end  if params[:flash]
  end
end
