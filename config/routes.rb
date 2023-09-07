Rails.application.routes.draw do
  get 'bads/create'
  get 'bads/destroy'
  get 'likes/create'
  get 'likes/delete'
  get 'password_resets/new'
  get 'password_resets/edit'
  root   "static_pages#home"
  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  post   "/search",  to: "users#search"
  get   "/show_likes",    to: "users#show_likes"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]  do
    resources :messages,           only: [:index, :new, :edit, :create, :update, :destroy]
    member do
      get :show_user
      get :bad_user
      post :revive
    end
  end
  resources :relationships,       only: [:create, :destroy]
    
  get '/microposts', to: 'static_pages#home'
  get '/deleted_microposts', to: 'microposts#deleted_post_index'
  get "/new", to: "static_pages#new"
end
