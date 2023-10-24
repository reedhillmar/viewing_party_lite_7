Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "welcome#index"
  get "/register", to: "users#new"
  get '/login', to: "users#login_form"
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'
  get '/dashboard', to: 'users#show', as: 'dashboard'
  get '/discover', to: 'users#discover', as: 'discover'
  get '/movies', to: 'movies#index', as: 'movies'
  get '/movies/:id', to: 'movies#show', as: 'movie'
  get '/movies/:id/viewing_parties/new', to: 'viewing_parties#new', as: 'new_viewing_party'

  namespace :admin do
    resources :users, only: :show
  end
  
  resources :users, only: :create

  resources :viewing_parties, only: :create

end
