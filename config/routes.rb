Rails.application.routes.draw do
  resources :missions do
    member do
      get :check_in
    end
  end

  resources :tags

  resources :games do
    member do
      get :text
      post 'text' => 'games#text_post'
    end
  end

  resources :players

  resources :users, except: [:new, :create]

  root :to => "games#index"
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
