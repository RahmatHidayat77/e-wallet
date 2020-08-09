Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  # get 'sessions', to: ‘sessions#create’, as: 'login'
  namespace :api, defaults: { format: 'json' }  do
    # your api json routes...
    resources :bank_histories
    resources :balance_banks
    resources :user_balance_histories
    resources :user_balances
    resources :users
    post 'signup', to: 'users#create'
    post 'auth/login', to: 'authentication#authenticate'
  end
  
  
  # resources :sessions, only: [:new, :create, :destroy]
  # get 'signup', to: 'users#new'
  # get 'login', to: 'sessions#new'
  # post 'login', to: 'sessions#create'
  # post 'logout', to: 'sessions#destroy'

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
