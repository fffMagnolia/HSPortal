# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  # === root ===
  root 'static_pages#home'
  # === static pages ===
  get '/explain', to: 'static_pages#explain'
  get '/help', to: 'static_pages#help'
  get '/policy', to: 'static_pages#policy'
  # === rename ===
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/contact', to: 'inquiries#new'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :events, only: [:new, :create, :edit, :update, :index, :show]
  resources :entries, only: [:create]
  resources :infos, only: [:new, :create, :show, :destroy]
  resources :inquiries, only: [:new, :create]

  # 最終行に書く必要があることに注意
  get '*path', to: 'application#render_404'
end
