# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/policy', to: 'static_pages#policy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :users
end
