Rails.application.routes.draw do
  resources :pictures, param: :token, path: '/p'

  devise_for :users, path: '/u'

  get 'welcome/index'

  root 'welcome#index'
end
