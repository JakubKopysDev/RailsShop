# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartsController do
  describe 'GET #show' do
    context 'as logged in user' do
      before { sign_in FactoryGirl.create :user }
      it 'can see cart' do
        get '/cart'
        expect(response.status).to be(200)
      end
    end

    context 'without login' do
      it 'returns unauthorized respons and redirects to login page' do
        get '/cart'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
