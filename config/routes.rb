Rails.application.routes.draw do
  
  resources :accounts
  resources :tweets

  root to: 'accounts#index'
end
