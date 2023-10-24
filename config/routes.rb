Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "welcome#index"
  get "/register", to: "users#new"
  get '/login', to: "users#login_form"
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'
  
  resources :users, only: [:create, :show] do
    get "/discover", to: "users#discover"
    resources :movies, only: [:index, :show] do
      resources :viewing_parties, only: :new
    end
  end

  resources :viewing_parties, only: :create

end
