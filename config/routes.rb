Zstore::Application.routes.draw do
  get "carts/show"

  get "cart_items/create"

  resources :categories
  resources :products
  resources :cart_items
  resources :carts
  
  match '/cart' => 'carts#show', as: :current_cart
  root :to => "products#index"
end