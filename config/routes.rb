Rails.application.routes.draw do

	root 'static_pages#home'
	get 'help'  =>  'static_pages#help'
	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'
	get '/users/:id/edit' => 'users#edit'
	get '/signup' => 'users#new'
	post '/signup' => 'users#create'
	resources :books do
		resources :request_details
		resources :reviews
		# , except: [:show, :index]
	end
	#User
	resources :users do
		member do
			resources :carts, only: [:index]
			get :following, :followers, :followingbook, :followingauthor, :likebook
		end
	end
	resources :requests do
    	member do
	      get "confirm_request"
	      get "accept_request"
	      get "decline_request"
	      get "cart"
	      # resources :carts, only: [:index]
	      resources :request_details, only:[:destroy]
    	end
  	end
  	resources :requests_details do
    	member do
    	end
  	end
	resources :relationships, only: [:create, :destroy] 
	resources :follows, only: [:create, :destroy]
	resources :categories
	resources :authors
	resources :likes, only: [:create, :destroy]
	resources :reviews
	
end
