# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart = Cart.find_by(user: current_user)

    @cart ||= current_user.create_cart

    @cart_items = @cart.cart_items.includes(:product)
    @users = User.all
  end
end
