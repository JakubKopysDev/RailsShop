# frozen_string_literal: true

if Rails.env.in? %w[development test]
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  task(:default).clear.enhance [
    'rubocop',
    'db:test:prepare',
    'db:environment:set',
    'spec',
    'brakeman:check'
  ]
end
