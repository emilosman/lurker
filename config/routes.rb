Rails.application.routes.draw do
  
  resources :accounts do
    member do
      get 'starred'
      get 'unread'
      post 'refresh_tweets'
    end
  end

  resources :tweets do
    collection do
      get 'starred'
    end
    member do
      post 'star'
    end
  end

  root to: 'accounts#index'
end
