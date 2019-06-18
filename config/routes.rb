Rails.application.routes.draw do
  	
	root 'static_pages#index'
	resources :books
	resources :authors
	devise_for :users

end
