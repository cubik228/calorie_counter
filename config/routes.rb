# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :products

  resources :meals do
    member do
      get 'add_product'
      post 'create_consumed_product'
      delete 'destroy_consumed_product/:consumed_product_id', to: 'meals#destroy_consumed_product', as: 'destroy_consumed_product'
      get 'generate_pdf'
    end
  end

  resources :consumed_products
  get 'documents/generate_pdf', format: :pdf

  root 'main#index'
end
