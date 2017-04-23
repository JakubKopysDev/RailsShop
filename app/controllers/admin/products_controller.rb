class Admin::ProductsController < ApplicationController
  before_filter :authorize_admin
  before_action :find_product, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @product.update product_params
      redirect_to products_path, notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def index
    @products = Product.order('created_at DESC').paginate(page: params[:page], per_page: 7)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params

    if @product.save
      redirect_to products_path, notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end

  def find_product
    @product = Product.find params[:id]
  end
end
