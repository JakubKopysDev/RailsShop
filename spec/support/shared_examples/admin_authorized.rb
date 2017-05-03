# frozen_string_literal: true
RSpec.shared_examples 'admin_authorized' do
  context 'when user is not logged in' do
    it 'is unauthorized and returns error message' do
      get '/products'
      expect(response).to be_unauthorized
      expect(JSON.parse(response.body)).to have_key 'errors'
    end
  end
  context 'when user without admin access is logged in' do
    require 'support/helpers/session_helper'
    include SessionHelper
    it 'is unauthorized' do
      auth_get '/admin/products'
      expect(response).to be_unauthorized
    end
  end
end
