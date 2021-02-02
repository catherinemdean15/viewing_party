Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, only: [:new, :create, :destroy] do 
    member { get 'dashboard'}
  end

  resources :sessions, only: [:new, :create, :destroy]
  get 'registration', to: 'users#new', as: 'registration'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
