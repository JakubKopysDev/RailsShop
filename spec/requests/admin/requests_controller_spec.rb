# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProductsController do
  let(:user)          { FactoryGirl.create :user }
  let(:admin_user)    { FactoryGirl.create :admin_user }
  let(:ticket)        { FactoryGirl.create :ticket }
  let(:ticket_params) { FactoryGirl.attributes_for :ticket }

  describe 'GET #tickets' do
    context 'as a guest' do
      it 'fails and redirects to Admin Login page' do
        get '/admin/tickets'
        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end

    context 'as logged in admin' do
      before { sign_in admin_user }
      it 'is success and renders products index' do
        get '/admin/tickets'
        expect(response).to render_template(:index)
      end
    end
  end


end
