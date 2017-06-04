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

  def autocomplete
    render json: Product.autocomplete_json(params[:query].downcase)
  end

  def search
    # TODO: move logic to model
    term = params[:query].downcase

    @products = Product.includes(:pictures, :categorizations)
                       .eager_load(:categories)
    @products = @products.where("lower(products.name) LIKE ?", "%#{term}%") if term
    if params[:categories]
      categories_ids = params[:categories].values.map(&:to_i)
      @products = @products.where("categories.id IN (?)", categories_ids)
    end

    @products = @products.order(created_at: :desc)
                         .paginate(page: params[:page], per_page: 9)

    render :index
  end
end
