Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' }  do
    # your api json routes...
    resources :bank_histories
    resources :balance_banks
    resources :user_balance_histories
    resources :user_balances
    resources :users
    post 'signup', to: 'users#create'
    post 'auth/login', to: 'authentication#authenticate'

    post 'topup', to: 'transaction#topup'
    post 'transfer', to: 'transaction#transfer'

  end
  
  
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
