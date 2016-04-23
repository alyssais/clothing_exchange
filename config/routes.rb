Rails.application.routes.draw do
  devise_for :users
  resources :items
  resources :locations, only: [:index]
end
