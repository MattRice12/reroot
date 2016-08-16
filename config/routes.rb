Rails.application.routes.draw do
  resources :tabs, as: 'tabs'
  resources :trees, as: 'trees'
  resources :users, as: 'users'

  post :search, controller: 'search', as: 'search'
  root 'trees#index', as: 'root'
end
