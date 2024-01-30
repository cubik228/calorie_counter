# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users, only: [:index] do
    collection do
      get :profile
    end
  end

  resources :products

  resources :meals do
    member do
      get 'add_product'
      post 'create_consumed_product'
      delete 'destroy_consumed_product/:consumed_product_id', to: 'meals#destroy_consumed_product',
                                                              as: 'destroy_consumed_product'
      get 'generate_pdf'
    end
  end

  resources :consumed_products
  get 'documents/generate_pdf', format: :pdf

  root 'main#index'
end
