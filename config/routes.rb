# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  #get 'users/new'
  get 'static_pages/help'

  root 'static_pages#home'

  resources :users
end
