Rails.application.routes.draw do
  	
	root 'static_pages#index'
	resources :books
	resources :authors
	
	post '/sort', to: "books#sort"
	devise_for :users
	resources :carts
	resources :requests

end
