Zstore::Application.routes.draw do

  resources :payment_notifications
  resources :categories
  resources :products
  resources :cart_items
  resources :carts
  
  match '/cart' => 'carts#show', as: :current_cart
  root :to => "products#index"
end