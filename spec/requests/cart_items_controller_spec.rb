# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItemsController, type: :request do
  context 'POST #create' do
    context 'as not logged in user' do
      it 'redirects to login page' do
        post '/cart_items'
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'as logged in user' do
      before { sign_in FactoryGirl.create :user }
      it 'is success and creates new Cart Item' do
        product = FactoryGirl.create :product

        expect do
          post '/cart_items', params: { product_id: product.id }
        end.to change { CartItem.count }.by(1)

        expect(response).to redirect_to(products_path)
      end
    end
  end
end
