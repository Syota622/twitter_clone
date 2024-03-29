# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(_resource)
    root_path
  end

  def configure_permitted_parameters
    added_attrs = %i[email password password_confirmation remember_me first_name last_name phone_number
                     birthdate]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
