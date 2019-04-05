Rails.application.routes.draw do

 
	root 'static_pages#home'
  	get 'help'  =>  'static_pages#help'

	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'

	
	
	resources :categories
	resources :authors
	#User
	resources :users do
    	member do
    		get :following, :followers
    	end
  	end
  	get '/users/:id/edit' => 'users#edit'
	get '/signup' => 'users#new'
	post '/signup' => 'users#create'

	resources :relationships, only: [:create, :destroy] 

end
