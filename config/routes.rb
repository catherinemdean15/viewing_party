Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, only: [:create, :destroy] do 
    member { get 'dashboard'}
    resources :friendships, only: [:create]
  end

  resources :sessions, only: [:create]
  get 'registration', to: 'users#new', as: 'registration'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
