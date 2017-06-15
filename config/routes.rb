Rails.application.routes.draw do
  get 'pages/index'

  root 'tweets#home'

  # root 'pages#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: %i[create destroy]

  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through

  get 'tags/:tag', to: 'tweets#index', as: "tag"

  resources :tweets do
    member do
      post 'upvote'
      get 'retweet'
    end
    resources :replies
    collection do
      get 'feed'
    end
  end

  resources :notifications

  resources :admin

  namespace 'admin' do
    resources :users, :tweets, :replies, only: [:index]
  end
end
