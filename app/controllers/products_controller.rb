# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.order('created_at DESC')
                       .includes(:categories, :pictures)
                       .paginate(page: params[:page], per_page: 9)
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.includes(:user)
                       .paginate(page: params[:page], per_page: 6)
  end
end
