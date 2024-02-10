Rails.application.routes.draw do
  #get  "/static_pages/home", to: "static_pages#home"
  #root "/static_pages/home"
  root "static_pages#home"

  #root "static_pages/home"
  #root "static_pages#home"
  #get 'password_resets/new'
  #get 'password_resets/edit'
  #root "static_pages#home"
  get "/signup", to: "users#new"
  get "/login", to:  "sessions#new"
  post "/login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  post "/guest_login", to: "sessions#guest_login"
  get '/posts/search_form', to: "posts#search_form"
  get '/posts/search', to: "posts#search"
  get '/restaurants/search_form', to: "restaurants#search_form"
  get '/restaurants/search', to: "restaurants#search"
  get '/restaurants/choose_form', to: "restaurants#choose_form"
  get '/restaurants/choose', to: "restaurants#choose"
  resources :users
  resources :restaurants, only: [:index,:show,:new,:create,:edit,:update,:destroy]
  resources :likes, only: [:index,:create,:destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :posts, only: [:new,:create,:edit,:update,:destroy]
  #get '/restaurants/:id', to: "restaurants#detail"

end