# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { user = FactoryGirl.create :user }

  describe 'GET #profile' do
    context 'as a guest' do
      it 'redirects to login page' do
        get '/profile'
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'as logged in user' do
      before { sign_in user }
      it 'renders profile page with valid info' do
        get '/profile'

        expect(response).to render_template(:profile)
        expect(response.body).to include(user.city)
      end
    end
  end

  describe 'PUT #update_profile' do
    context 'as a guest' do
      it 'redirects to login page' do
        put '/update_profile'
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'as logged in user' do
      before { sign_in user }
      context 'with valid params' do
        it 'is success and updates users profile' do
          params = {
            country: 'PL',
            city: 'foobar',
            street: 'foobar',
            phone_number: '+48666666666'
          }

          put '/update_profile', params: { user: params }
          user.reload

          expect(user.city).to eq(params[:city])
        end
      end

      context 'with invalid country code' do
        it 'does not update user and displays error' do
          params = {
            country: 'foobar',
            city: 'foobar',
            street: 'foobar',
            phone_number: '+48666666666'
          }

          put '/update_profile', params: { user: params }

          expect(user.reload.city).not_to eq(params[:city])

          body = response.body
          expect(body).to include('error', 'is not a valid Country Code')
        end
      end

      context 'with invalid post code' do
        it 'does not update user and displays error' do
          params = {
            country: 'PL',
            post_code: '3233223'
          }

          put '/update_profile', params: { user: params }

          expect(user.reload.city).not_to eq(params[:city])

          body = response.body
          expect(body).to include('error', 'Zipcode is invalid')
        end
      end

      context 'with invalid params' do
        it 'does not update user' do
          params = {
            city: 'fo',
            street: 'ba',
            phone_number: '866666666'
          }

          put '/update_profile', params: { user: params }

          expect(user.reload.city).not_to eq(params[:city])
        end
      end
    end
  end
end
