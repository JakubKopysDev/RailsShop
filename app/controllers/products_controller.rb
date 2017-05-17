# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.order('created_at DESC').includes(:categories)
                       .paginate(page: params[:page], per_page: 9)
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.includes(:user).all
  end
end
