Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, only: %i[create destroy] do
    member { get 'dashboard' }
    resources :friends, only: [:create]
    resources :parties, only: [:new]
  end

  resources :sessions, only: [:create]
  get 'registration', to: 'users#new', as: 'registration'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :movies, only: %i[index show]
  get 'discover', to: 'movies#discover', as: 'discover'
end
