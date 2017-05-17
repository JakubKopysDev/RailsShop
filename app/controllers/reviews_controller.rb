# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    product = Product.find(params[:product_id])

    @review = product.reviews.build(reviews_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(product), notice: 'Review added'
    else
      render :show
    end
  end

  def destroy
    # TODO: cancan - destroy only yours comments
    @review = Review.find(params[:id])
    product = @review.product
    @review.destroy
    redirect_to product_path(product.id), notice: 'Review deleted'
  end

  private

  def reviews_params
    params.require(:review).permit(:comment, :rating)
  end
end
