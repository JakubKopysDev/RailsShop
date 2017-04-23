class ProductsController < ApplicationController
  before_action :find_product, only: [:show]

  def index
    @products = Product.order('created_at DESC').paginate(page: params[:page], per_page: 9)
  end

  def show
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end

  def find_product
    @product = Product.find params[:id]
  end
end
