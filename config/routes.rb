Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  authenticated do
    root to: 'home#index', as: :authenticated
    # namespace :admin do
    #  get '', to: 'admin#index', as: '/'
    #  resources :products, only: [:index, :new, :edit, :create, :update, :destroy]
    #  resources :users, only: [:index, :destroy]
    # end
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :products, only: [:index, :show]
end
