class CartsController < ApplicationController
  def show
    @cart = Cart.find_by(user: current_user)

    if @cart.nil?
      @cart = current_user.create_cart
    end

    @cart_items = @cart.cart_items.includes(:product)
    @users = User.all
  end
end
