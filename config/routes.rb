Rails.application.routes.draw do
  resources :tabs, as: 'tabs'
  resources :trees, as: 'trees'
  resources :users, as: 'users'

  root 'trees#index', as: 'root'
end
