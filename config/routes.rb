Rails.application.routes.draw do
  resources :missions

  resources :tags

  resources :games

  resources :players

  resources :users, except: [:new, :create]

  root :to => "users#index"
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
