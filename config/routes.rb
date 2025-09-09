Rails.application.routes.draw do
  get "home/index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions" }

  authenticated :user do
    root to: "products#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "home#index", as: :unauthenticated_root
  end

  resources :products
  resources :cart_items

  resource :two_factor_settings, only: [ :show ] do
    collection do
      get :setup        # scan QR and enter code
      post :confirm     # confirm setup
      delete :disable   # disable 2FA
      post :regenerate_backup_codes
    end
  end

  devise_scope :user do
    get  "users/otp_login",    to: "users/sessions#otp_login"
    post "users/verify_otp",   to: "users/sessions#verify_otp"
  end

  resource :two_factor_session, only: [ :new, :create ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
