Rails.application.routes.draw do
  resources :games do
    resources :groups do
      post 'join', on: :member
      resources :comments, only: %i[create]
    end
  end
  post 'select_game', to: 'home#select_game', as: 'select_game'
  devise_for :users
  root 'home#index'
  resources :profiles, path: '/profile', param: :username do
    resources :comments, only: %i[create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
