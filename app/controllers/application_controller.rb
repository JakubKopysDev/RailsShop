# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_categories

  def disable_header
    @disable_header = true
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def set_categories
    @categories = Category.all
  end

  def configure_permitted_parameters
    user_attrs = %i[name email password password_confirmation remember_me]
    avatar_attrs = %i[avatar avatar_cache remove_avatar]
    attrs = user_attrs + avatar_attrs
    devise_parameter_sanitizer.permit :sign_up, keys: attrs
    devise_parameter_sanitizer.permit :sign_in, keys: attrs
    devise_parameter_sanitizer.permit :account_update, keys: attrs
  end
end
