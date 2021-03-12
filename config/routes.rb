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
    resources :thumbs, only: %i[create]
  end
  namespace :load_test do
    get 'sign_in_as_new_user'
    get 'seed_games'
    get 'seed_groups/:num_games/:num_groups' => '/load_test#seed_groups'
    get 'seed_users/:num_users' => '/load_test#seed_users'
    get 'reset_table/:table' => '/load_test#reset_table'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
