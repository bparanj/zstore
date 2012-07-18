class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  # TODO: Implement this properly. Refer AWD project. 
  def current_cart
    @current_cart ||= Cart.first || Cart.create!  
  end
end
