class PaymentNotification < ActiveRecord::Base
  attr_accessible :cart_id, :params, :status, :transaction_id
  
  belongs_to :cart
  serialize :params
  
  after_create :mark_cart_as_purchased
  
  private
  
  def mark_cart_as_purchased
    if status == 'Completed'
      cart.update_attribute(:purchased_at, Time.now)
    end
  end
end
