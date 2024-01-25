Rails.application.routes.draw do
  devise_for :users
  resources :users
  root 'main#index'
end
