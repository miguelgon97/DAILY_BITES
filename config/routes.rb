Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :recipes, only: %i[index show] do
    member do
      post 'toggle_favorite', to: "recipes#toggle_favorite"
    end
  end
  resources :users, only: %i[show update]
  get "profile", to: "pages#profile"
end
