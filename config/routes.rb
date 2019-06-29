Rails.application.routes.draw do

	root 'static_pages#index'
	devise_for :users
	resources :books
	resources :authors
	post '/sort', to: "books#sort"
	get '/get_rq_json', to: "requests#get_rq_json"
	post '/get_request_params', to: "carts#get_request_params"
	resources :carts do
		member do
			get "confirm"
			get "accept"
			get "decline"
		end
	end
	resources :requests 

end
