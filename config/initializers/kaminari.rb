# frozen_string_literal: true

# configure an initializer for Kaminari to avoid conflicts with ActiveAdmin
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end
