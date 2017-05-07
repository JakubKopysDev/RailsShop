# frozen_string_literal: true

require_relative 'macros'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend Macros
end
