module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :firstname << :surname << :gender
    devise_parameter_sanitizer.for(:account_update) << :firstname << :surname << :gender
  end

end

DeviseController.send :include, DevisePermittedParameters
