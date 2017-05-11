# frozen_string_literal: true

module ApplicationHelper
  def resource
    @resource ||= User.new
  end

  def resource_name
    resource.class.name.downcase.to_sym
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[resource_name]
  end
end
