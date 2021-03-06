# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProductsController do
  describe 'GET #products' do
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

  describe 'POST #products' do
    let(:categories) { FactoryGirl.create_list :category, 4 }
    let(:product) { FactoryGirl.build :product }

    context 'as a guest' do
      it 'fails' do
        params = {
          name: product.name,
          description: product.description,
          price: product.price,
          image: product.image
        }

        post '/admin/products', params: params

        expect do
          post '/admin/products', params: { product: params }
        end.not_to change(Product, :count)

        expect(response).to redirect_to(new_admin_user_session_path)
      end
    end

    context 'as logged in admin' do
      before { sign_in FactoryGirl.create :admin_user }
      context 'with valid params' do
        it 'creates new product with default picture' do
          params = {
            name: product.name,
            description: product.description,
            price: product.price,
            category_ids: categories.take(3).pluck(:id)
          }

          expect do
            post '/admin/products', params: { product: params }
          end.to change(Product, :count).by(1)
            .and change(Picture, :count).by(1)

          product_picture = Product.last.pictures.last
          newest_picture = Picture.last

          expect(product_picture).to eq(newest_picture)

          expect(response).to redirect_to(admin_products_path)
          follow_redirect!

          expect(response).to render_template(:index)
        end
      end

      context 'with duplicate params' do
        it 'does not create new product' do
          product.save
          params = {
            name: product.name,
            description: product.description,
            price: product.price
          }

          expect do
            post '/admin/products', params: { product: params }
          end.not_to change(Product, :count)
          expect(response.body).to include('error')
        end
      end

      context 'with invalid params' do
        it 'does not create new product and returns error' do
          params = {
            name: 'a',
            description: '',
            price: 'invalid'
          }

          expect do
            post '/admin/products', params: { product: params }
          end.not_to change(Product, :count)
          expect(response.body).to include('error')
        end
      end

      context 'with too many category_ids' do
        it 'does not create new product and returns error' do
          params = {
            name: product.name,
            description: product.description,
            price: product.price,
            category_ids: categories.take(4).pluck(:id)
          }

          expect do
            post '/admin/products', params: { product: params }
          end.not_to change(Product, :count)
          expect(response.body).to include('too many', 'error')
        end
      end

      context 'with pictures' do
        let(:file) { fixture_file_upload(Rails.root.join('spec', 'support', 'images', 'default.png'), 'image/png') }

        context 'that are valid' do
          it 'creates product with pictures' do
            params = {
              name: product.name,
              description: product.description,
              price: product.price,
              category_ids: categories.take(3).pluck(:id),
              pictures_attributes: [
                { file: file },
                { file: file },
                { file: file }
              ]
            }

            expect do
              post '/admin/products', params: { product: params }
            end.to change(Product, :count).by(1)
              .and change(Picture, :count).by(3)
          end
        end

        context 'that exceed valid count' do
          it 'does not create any products nor pictures' do
            params = {
              name: product.name,
              description: product.description,
              price: product.price,
              category_ids: categories.take(3).pluck(:id),
              pictures_attributes: [
                { file: file },
                { file: file },
                { file: file },
                { file: file },
                { file: file },
                { file: file }
              ]
            }

            expect do
              post '/admin/products', params: { product: params }
            end.to change(Product, :count).by(0)
              .and change(Picture, :count).by(0)
          end
      end
      end
    end
  end
end
