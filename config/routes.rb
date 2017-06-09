Rails.application.routes.draw do

  get 'pages/index'

  root 'tweets#home'

  # root 'pages#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :tweets do
    member do
      post 'upvote'
    end
    resources :replies
      collection do
        get 'feed'
      end
    end


  resources :admin



  namespace "admin" do
    resources :users, :tweets, :replies, only: [:index]
  end

end
