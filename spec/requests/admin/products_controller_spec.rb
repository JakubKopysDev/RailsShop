# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProductsController do
  describe 'GET admin#products' do
    context 'as a guest' do
      it 'fails and redirects to Admin Login page' do
        get '/admin/products'
        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end

    context 'as logged in admin' do
      before { sign_in FactoryGirl.create :admin_user }
      it 'is success and renders products index' do
        get '/admin/products'
        expect(response).to render_template(:index)
      end
    end
  end
end
