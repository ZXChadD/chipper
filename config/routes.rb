Rails.application.routes.draw do

  root 'tweets#home'

  devise_for :users

  resources :tweets do
    resources :replies
  end

  resources :admin do
    resources :users, :tweets, :replies, only: [:index]
  end
end
