class CartItemsController < ApplicationController
  def create
    @cart = Cart.find_by(user: current_user)
		product = Product.find(params[:product_id])

    if @cart.nil?
      @cart = current_user.create_cart
    end

    @cart_item = @cart.cart_items.create!({product: product})

    redirect_to products_path
  end

	def destroy
		@cart_item = CartItem.find(params[:id])
		@cart_item.destroy
		redirect_to cart_path
	end
end
