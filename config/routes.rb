Rails.application.routes.draw do

  root 'tweets#home'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :tweets do
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
