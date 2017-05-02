class ProductsController < ApplicationController
  respond_to :html, :json
  before_action :find_product, only: [:edit, :update]

  def index
    #@products = Product.order('created_at DESC').paginate(page: params[:page], per_page: 8)
    # @products = Product.select(:id, :name).all
    # render json: @products
    @products = Product.select(:id, :name).all
    render json: @products.map{ |product| { id: product.id, text: product.name } }
    # respond_with @products
      # f.json {
      #   render json: Product.select(:id, :name).all
      # }

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

  def edit
  end

  def update
    if @product.update product_params
      redirect_to products_path, notice: 'Product was successfully updated.'
    else
      render action: 'edit'
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
