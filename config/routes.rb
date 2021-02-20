Rails.application.routes.draw do
  devise_for :users
  resources :groups
  root 'home#index'
  resources :users
  get '/login', to:'users#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
