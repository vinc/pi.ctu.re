Rails.application.routes.draw do
  resources :pictures, param: :token

  devise_for :users

  get 'welcome/index'

  root 'welcome#index'
end
