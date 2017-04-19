Rails.application.routes.draw do
  devise_for :users

  authenticated do
    root to: 'home#index', as: :authenticated
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :products
end
