Rails.application.routes.draw do
  resources :albums, param: :token, path: 'a' do
    #resources :pictures, only: [:index]
  end

  resources :pictures, param: :token, path: 'p' do
    member do
      get 'lightbox'
      put 'like'
      put 'unlike'
    end
  end

  resources :users, param: :username, path: 'u', only: [:show, :edit, :update] do
    #resources :pictures, only: [:index]
    resources :albums, only: [:index]
  end

  devise_for :users, path: 'account'

  namespace :account do
    resource :settings, only: [:edit, :update]
  end

  get 'explore' => 'pictures#index'

  root 'welcome#index'
end
