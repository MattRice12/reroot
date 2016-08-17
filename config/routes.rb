Rails.application.routes.draw do
  resources :tabs, as: 'tabs'
  resources :trees, as: 'trees'

  get    '/sign_in'     => 'sessions#new',     as: 'sign_in'
  delete '/sign_out'    => 'sessions#destroy', as: 'sign_out'
  get    '/sign_up'     => 'users#new',        as: 'sign_up'

  resources :passwords, controller: 'passwords', only: [:create, :new]
  resource  :session,   controller: 'sessions',  only: [:create]
  resources :users,     controller: 'users' do
    resource  :password,  controller: 'passwords', only: [:create, :edit, :update]
  end

  post :search, controller: 'search', as: 'search'
  root 'trees#index', as: 'root'
end
