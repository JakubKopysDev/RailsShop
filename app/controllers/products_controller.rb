# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: %i[show]

  def index
    @products = Product.order('created_at DESC')
                       .paginate(page: params[:page], per_page: 9)
  end

  def show; end

  private

  def find_product
    @product = Product.find params[:id]
  end
end
