Rails.application.routes.draw do
  resources :tabs
  resources :trees
  resources :users

  root 'trees#index', as: 'root'
end
