class CartItemsController < ApplicationController
# TODO : This is LineItemsController
  def create
    current_cart.cart_items.create!(params[:cart_item])
    session[:last_product_page] = request.headers["Referer"] || products_url
    
    redirect_to current_cart_url, notice: 'Product added to cart'
  end

end
