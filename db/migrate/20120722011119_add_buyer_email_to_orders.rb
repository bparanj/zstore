class AddBuyerEmailToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :buyer_email, :text
  end
end
