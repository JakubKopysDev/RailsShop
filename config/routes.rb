# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  authenticated :user do
    root to: 'home#index', as: :authenticated
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :products, only: [:index, :show]

  authenticate :user do
		get :cart, to: 'carts#show'
		resources :cart_items, only: [:create, :destroy]
  end
end
