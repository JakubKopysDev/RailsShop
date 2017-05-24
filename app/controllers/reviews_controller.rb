# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review, only: %i[destroy update]
  load_and_authorize_resource

  def create
    product = Product.find(params[:product_id])

    @review = product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(product), notice: 'Review added'
    else
      # TODO: display errors
      render product
    end
  end

  def destroy
    product = @review.product
    @review.destroy
    redirect_to product_path(product.id), notice: 'Review deleted'
  end

  def update
    product = @review.product
    if @review.update_attributes(review_params)
      redirect_to product, notice: 'Review updated'
    else
      render product
    end
  end

  private

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
