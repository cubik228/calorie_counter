# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :products

   resources :meals do
    member do
      get 'add_product'
      post 'create_consumed_product'
    end
  end

  resources :consumed_products
  
  root 'main#index'
end
