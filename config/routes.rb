Rails.application.routes.draw do
  devise_for :users, path: "account", path_names: {
    sign_up: "signup",
    sign_in: "signin",
    sign_out: "signout"
  }

  namespace :account do
    get "/", to: redirect("/account/settings/edit")
    get "/settings", to: redirect("/account/settings/edit")
    resource :settings, only: %i[edit update]
    resource :billing, only: :show
    resources :charges, only: :create
  end

  resources :pictures, param: :token, path: "p" do
    resource :lightbox, only: %i[show], module: :pictures
    resource :featured, only: %i[create destroy], module: :pictures
    resource :like, only: %i[create destroy], module: :pictures

    collection do
      get "import"
      get "search"
    end
  end

  get "/u", to: redirect("/explore")
  resources :users, param: :username, path: "u", only: %i[show edit update] do
    member do
      put "follow"
      put "unfollow"
      get "followers"
      get "followees"
    end

    resources :albums, only: [:index]
    resources :pictures, only: [:index]
  end

  get "/a", to: redirect("/explore")
  resources :albums, param: :token, except: :index, path: "a" do
    resources :pictures, only: [:index]
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
  get "rules" => "about#rules"

  devise_scope :user do
    authenticated :user do
      root "timeline#index"
    end

    unauthenticated do
      root "welcome#index"
    end
  end
end
