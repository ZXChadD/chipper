Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tweets do
    resources :replies
  end

  root 'tweets#home'

end
