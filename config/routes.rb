Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/", to: "welcome#index"
  get "/register", to: "users#new"

  resources :users, only: [:new, :show] do
    get "/:id/discover", to: "users#discover"
    resources :movies, only: [:index, :show] do
      resources :viewing_parties, only: :new
    end
  end

end
