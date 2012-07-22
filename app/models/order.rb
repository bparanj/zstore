class Order < ActiveRecord::Base
  # attr_accessible :cart_id, :first_name, :last_name
  attr_protected :ip_address

  belongs_to :cart
  has_many :transactions, :class_name => "OrderTransaction"

  def purchase
    response = process_purchase
    transactions.create!(action: 'purchase', amount: price_in_cents, response: response)
    cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def price_in_cents
    (cart.total_price*100).round
  end

  private

  def process_purchase
    ZephoPaypalExpress.purchase(price_in_cents, express_purchase_options)
  end

  def express_purchase_options
    {
      ip: ip_address,
      token: express_token,
      payer_id: express_payer_id
    }
  end

end

# TODO : Get rid of this SRP violating implementation...