Zstore::Application.routes.draw do
  
  resources :orders, :only => [:new, :create] 
  get '/express' => 'orders#express', as: :express

  resources :payment_notifications
  resources :categories
  resources :products
  resources :cart_items
  resources :carts
  
  match '/cart' => 'carts#show', as: :current_cart
  root :to => "products#index"
end