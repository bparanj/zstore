class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :products, :through => :cart_items
  
  def total_price
    cart_items.to_a.sum(&:full_price)
  end
  
  def paypal_url(return_url, notify_url)
    values = {
      :business => PAYPAL_CONFIG["paypal_email"],
      :cmd => "_cart",
      :upload => 1,
      :return => return_url,
      :invoice => id,
      :notify_url => notify_url    
    }
    cart_items.each_with_index do |item, index|
      values.merge!({
        # TODO: This should be item.unit_price
        "amount_#{index+1}" => item.product.price, 
        "item_name_#{index+1}" => item.product.name,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    name_value_pairs = values.map{|k,v| "#{k}=#{v}"}.join("&")
    PAYPAL_CONFIG["paypal_url"] + '?' + name_value_pairs
  end
end
