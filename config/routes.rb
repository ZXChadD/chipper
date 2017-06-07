Rails.application.routes.draw do

  root 'tweets#home'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
    resources :users do
      member do
        get :following, :followers
      end
    end

  resources :tweets do
    resources :replies
  end

  namespace "admin" do
    resources :users, :tweets, :replies, only: [:index]
  end

end
