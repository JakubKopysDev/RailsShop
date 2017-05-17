# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  authenticated :user do
    root to: 'products#index', as: :authenticated
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :products, only: %i[index show]
  authenticate :user do
    get :cart,            to: 'carts#show'
    get :profile,         to: 'users#profile'
    put :update_profile,  to: 'users#update_profile'

    resources :cart_items, only: %i[create destroy]
    resources :products, only: %i[] do
      resources :reviews, only: %i[create destroy], shallow: true
    end
  end
end
