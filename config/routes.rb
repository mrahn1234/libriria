Rails.application.routes.draw do

 
	root 'users#index'

	get    '/login',   to: 'sessions#new'
	post   '/login',   to: 'sessions#create'
	delete '/logout',  to: 'sessions#destroy'

	get '/users/:id/edit' => 'users#edit'
	get '/signup' => 'users#new'
	post '/signup' => 'users#create'
	
	resources :categories
	resources :authors
	resources :users

end
