Rails.application.routes.draw do
  get    '/sign_in'     => 'clearance/sessions#new',     as: 'sign_in'
  delete '/sign_out'    => 'clearance/sessions#destroy', as: 'sign_out'
  get    '/sign_up'     => 'clearance/users#new',        as: 'sign_up'

  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource  :session,   controller: 'clearance/sessions',  only: [:create]
  resources :users,     controller: 'clearance/users' do
    resource  :password,  controller: 'clearance/passwords', only: [:create, :edit, :update]
  end

  resources :members, as: 'members' do
    member do
      delete 'boot'
      delete 'leave'
    end
  end

  resources :projects, as: 'projects' do
    member do
      put 'captain'
    end
  end

  resources :trees, as: 'trees' do
    member do
      get 'new_forest'
      post 'create_forest'
    end
  end

  resources :forests
  resources :tabs, as: 'tabs'
  resources :trees, as: 'trees'
  resources :archives, as: 'archives'

  post :search, controller: 'search', as: 'search'
  root 'trees#index', as: 'root'
end
