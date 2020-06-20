Rails.application.routes.draw do
  
  resources :accounts do
    member do
      get 'starred'
      post 'refresh_tweets'
    end
  end

  resources :tweets do
    member do
      post 'star'
    end
  end

  root to: 'accounts#index'
end
