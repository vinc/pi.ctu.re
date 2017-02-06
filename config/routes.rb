Rails.application.routes.draw do
  resources :pictures, param: :token, path: 'p' do
    member do
      get 'lightbox'
      put 'like'
      put 'unlike'
    end
  end

  resources :users, param: :username, path: 'u', only: [:show, :edit, :update]

  devise_for :users, path: 'account'

  get 'welcome/index'

  root 'welcome#index'
end
