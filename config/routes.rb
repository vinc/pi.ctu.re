Rails.application.routes.draw do
  resources :pictures, param: :token, path: 'p' do
    member do
      put 'like'
      put 'unlike'
    end
  end

  devise_for :users, path: 'u'

  resources :users, param: :username, path: 'u', only: :show

  get 'welcome/index'

  root 'welcome#index'
end
