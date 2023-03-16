Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show update]
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  # root "articles#index"
  resources :recipes, only: %i[index show] do
    member do
      post 'toggle_favorite', to: "recipes#toggle_favorite"
    end
    resources :reviews, only: %i[create]
  end

  get "ingredients", to: "ingredients#index"
  get "profile", to: "pages#profile"
  get "map", to: "supermarkets#map"
end
