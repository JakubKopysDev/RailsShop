# frozen_string_literal: true

require 'rails_helper'
require 'support/devise'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    login_user

    it 'has a current_user' do
      expect(subject.current_user).not_to eq(nil)
    end
  end
end
