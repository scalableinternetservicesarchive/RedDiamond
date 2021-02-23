Rails.application.routes.draw do
  resources :games do
    resources :groups
  end
  resources :home do
    post "select_game"
  end
  devise_for :users
  root 'home#index'
  resources :profiles, path: '/profile', param: :username
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
