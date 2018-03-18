Rails.application.routes.draw do
  resources :albums, param: :token, path: "a" do
    # resources :pictures, only: [:index]
  end

  resources :pictures, param: :token, path: "p" do
    collection do
      get "search"
    end

    member do
      get "lightbox"

      put "like"
      put "unlike"

      put "feature"
      put "unfeature"
    end
  end

  resources :users, param: :username, path: "u", only: %i[show edit update] do
    # resources :pictures, only: [:index]
    resources :albums, only: [:index]
  end

  devise_for :users, path: "account"

  namespace :account do
    resource :settings, only: %i[edit update]
    resource :billing, only: [:show]
    resources :charges, only: [:create]
  end

  namespace :admin do
    resources :users, param: :username, only: [:index]
    resources :invitations, param: :token, only: [:index] do
      member do
        put "approve"
      end
    end
  end

  resources :invitations, only: %i[new create]

  get "explore" => "explore#index"

  root "welcome#index"
end
