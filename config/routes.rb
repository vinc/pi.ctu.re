Rails.application.routes.draw do
  resources :pictures
  devise_for :users
  get 'welcome/index'

  root 'welcome#index'
end
