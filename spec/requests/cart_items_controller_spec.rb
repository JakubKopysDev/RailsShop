# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

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
        end.to change(CartItem, :count).by 1

        expect(response).to redirect_to(products_path)
      end
    end
  end

  context 'DELETE #destroy' do
    let(:user)    { FactoryGirl.create :user }
    let(:cart)    { FactoryGirl.create :cart, user: user }
    let(:product) { FactoryGirl.create :product }

    context 'as not logged in user' do
      it 'redirects to login page' do
        cart_item = FactoryGirl.create :cart_item, cart: cart, product: product
        expect do
          delete "/cart_items/#{cart_item.id}"
        end.not_to change(CartItem, :count)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'as logged in user' do
      before { sign_in user }
      it 'destroys cart item' do
        cart_item = FactoryGirl.create :cart_item, cart: cart, product: product

        expect do
          delete "/cart_items/#{cart_item.id}"
        end.to change(CartItem, :count).by(-1)
      end

      context 'on not owned item' do
        it 'does not destroy item and is redirected' do
          other_user = FactoryGirl.create :user
          other_cart = FactoryGirl.create :cart, user: other_user
          cart_item  = FactoryGirl.create :cart_item,
                                          cart: other_cart, product: product

          expect do
            delete "/cart_items/#{cart_item.id}"
          end.not_to change(CartItem, :count)

          expect(response).to redirect_to(root_url)
        end
      end
    end
  end
end
