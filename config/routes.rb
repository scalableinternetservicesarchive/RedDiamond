Rails.application.routes.draw do
  get '/' => 'home#index', as: 'home'

  get "/user", to: "user#index"
end
