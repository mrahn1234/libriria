Rails.application.routes.draw do

	get 'requests/new'
	get 'requests/create'
	root 'static_pages#home'
		get 'help'  =>  'static_pages#help'
	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'
	get '/users/:id/edit' => 'users#edit'
	get '/signup' => 'users#new'
	post '/signup' => 'users#create'
	resources :categories
	resources :authors
	resources :books do
		resources :requests
	end
	#User
	resources :users do
		member do
			get :following, :followers, :followingbook, :followingauthor
		end
	end
	resources :requests do
    	member do
	      get "accept_request"
	      get "decline_request"
    	end
  	end
	resources :relationships, only: [:create, :destroy] 
	resources :follows, only: [:create, :destroy]

  
end
