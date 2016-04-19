class ApplicationController < ActionController::Base
  respond_to :html, :json
  include ActionView::Helpers::SanitizeHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :resource_name, :resource, :devise_mapping, :affix_header?

  before_action :set_flash
  after_filter :set_csrf_cookie_for_ng
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

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

protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def set_flash
    params[:flash].each do |type, message|
      flash[type.to_sym] = sanitize(message[0..255])
    end  if params[:flash]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstname, :surname, :password, :email, :password_confirmation) }
  end
end
