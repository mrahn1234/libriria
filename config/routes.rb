Rails.application.routes.draw do

	root 'static_pages#index'
	devise_for :users
	# devise_for :users, controllers: { registrations: "registrations" }
	resources :books
	resources :authors
	post '/sort', to: "books#sort"
	get '/get_rq_json', to: "requests#get_rq_json"
	post '/get_request_params', to: "carts#get_request_params"
	resources :carts do
		member do
			get "confirm"
			post "confirm"
			get "accept"
			get "decline"
			get "my_cart"
			get "detail"
		end
	end
	resources :requests 

end
