# frozen_string_literal: true
require 'users/authentication'
module SessionHelper
  include Devise::Test::ControllerHelpers
  def auth_get(path, params: {}, headers: {}, user: nil)
    headers[:Authorization] = auth_token(user)
    get path, params: params, headers: headers
  end
end
