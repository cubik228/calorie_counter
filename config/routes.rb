# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :products
  resources :meals
  resources :consumed_products
  
  root 'main#index'
end
