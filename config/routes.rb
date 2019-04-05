Rails.application.routes.draw do
  resources :books
  # resources :categories
  root 'books#index'
end
