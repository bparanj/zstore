
desc 'Populate first_name, last_name and email fields of buyer. This is used for pdf stamping'
namespace :paypal do
  task :details => :environment do
    # Express Token is valid for 3 hours.
    orders = Order.where("created_at > :token_period", 
                {token_period: 3.hours.ago}).all

    puts "There are #{orders.size} orders to process"

    orders.each do |order|
      puts "Processing order : #{order.id}"
      details = ZephoPaypalExpress.details_for(order.express_token)
      # puts "Details : #{details.params}"
      order.express_payer_id = details.payer_id
      order.first_name = details.params["first_name"]
      order.last_name = details.params["last_name"]
      order.buyer_email = details.params['PayerInfo']["Payer"]    
      order.save
    end

  end  
end

