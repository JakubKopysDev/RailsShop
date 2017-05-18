# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :request do
  let(:user)    { FactoryGirl.create :user }
  let(:product) { FactoryGirl.create :product }
  let(:review)  { FactoryGirl.create :review, product: product, user: user }

  describe 'POST #create' do
    context 'as a guest' do
      it 'fails and redirects to login page' do
        params = {
          comment: 'valid comment',
          rating: Faker::Number.between(1, 5)
        }

        expect do
          post "/products/#{product.id}/reviews", params: { review: params }
        end.not_to change(Review, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'as logged in user' do
      before { sign_in user }

      context 'with valid params' do
        it 'creates new review' do
          review = FactoryGirl.create :review, user: user, product: product
          params = {
            comment: 'valid comment',
            rating: Faker::Number.between(1, 5)
          }

          expect do
            post "/products/#{product.id}/reviews", params: { review: params }
          end.to change(Review, :count).by(1)

          expect(Review.all).to include(review)
        end
      end

      context 'with invalid params' do
        it 'fails' do
          params = {
            comment: '',
            rating: 'foobar'
          }

          expect do
            post "/products/#{product.id}/reviews", params: { review: params }
          end.not_to change(Review, :count)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'as a guest' do
      it 'fails and redirects to login page' do
        review = FactoryGirl.create :review, user: user, product: product

        expect { delete "/reviews/#{review.id}" }.not_to change(Review, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'as logged in user' do
      before { sign_in user }
      context 'on users review' do
        it 'destroys review' do
          review = FactoryGirl.create :review, user: user, product: product

          old_review_count = product.review_count
          old_rating_cache = product.rating_cache

          expect do
            delete "/reviews/#{review.id}"
          end.to change(Review, :count).by(-1)

          product.reload

          expect(product.review_count).not_to eq(old_review_count)
          expect(product.rating_cache).not_to eq(old_rating_cache)
        end
      end

      context 'on other users review' do
        it 'does not destroy review' do
          other_user = FactoryGirl.create :user
          review.update(user: other_user)

          expect do
            delete "/reviews/#{review.id}"
          end.not_to change(Review, :count)
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'as a guest' do
      it 'fails and redirects to login page' do
        params = {
          comment: 'new comment'
        }

        put "/reviews/#{review.id}", params: { review: params }

        expect(review.comment).not_to eq(params[:comment])
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'as logged in user' do
      before { sign_in user }

      context 'on users review' do
        context 'with valid params' do
          it 'updates review' do
            review = FactoryGirl.create :review, product: product, user: user
            params = {
              comment: 'new comment'
            }

            put "/reviews/#{review.id}", params: { review: params }
            review.reload

            expect(review.comment).to eq(params[:comment])
          end
        end

        context 'with invalid params' do
          it 'does not update review' do
            review = FactoryGirl.create :review, product: product, user: user
            params = {
              comment: ''
            }

            put "/reviews/#{review.id}", params: { review: params }
            review.reload

            expect(review.comment).not_to eq(params[:comment])
          end
        end
      end

      context 'on other users review' do
        it 'does not update review' do
          other_user = FactoryGirl.create :user
          review.update(user: other_user)

          params = {
            comment: 'new comment'
          }

          put "/reviews/#{review.id}", params: { review: params }
          review.reload

          expect(review.comment).not_to eq(params[:comment])
        end
      end
    end
  end
end
