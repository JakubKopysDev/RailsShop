# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = Cart.find_by(user: current_user)
    product = Product.find(params[:product_id])

    @cart ||= current_user.create_cart

    @cart_item = @cart.cart_items.create!(product: product)

    redirect_to products_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path
  end
end
