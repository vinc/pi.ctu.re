Rails.application.routes.draw do
  resources :albums, param: :token, path: "a" do
    # resources :pictures, only: [:index]
  end

  resources :pictures, param: :token, path: "p" do
    collection do
      get "import"
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

  get "/u", to: redirect("/explore")
  resources :users, param: :username, path: "u", only: %i[show edit update] do
    # resources :pictures, only: [:index]
    resources :albums, only: [:index]
  end

  devise_for :users, path: "account"

  namespace :account do
    get "/", to: redirect("/account/settings/edit")
    get "/settings", to: redirect("/account/settings/edit")
    resource :settings, only: %i[edit update]
    resource :billing, only: [:show]
    resources :charges, only: [:create]
  end

  namespace :admin do
    get "/", to: redirect("/admin/users")
    resources :users, param: :username, only: [:index]
    resources :invitations, param: :token, only: [:index] do
      member do
        put "approve"
      end
    end
  end

  resources :invitations, only: %i[new create]

  get "explore" => "explore#index"
  get "contact" => "about#contact"
  get "pricing" => "about#pricing"
  get "privacy" => "about#privacy"
  get "terms" => "about#terms"

  root "welcome#index"
end
