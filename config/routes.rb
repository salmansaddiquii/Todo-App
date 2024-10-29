Rails.application.routes.draw do

  unauthenticated :user do
    root to: "homes#index", as: :unauthenticated_root
  end

  # Define the root path for authenticated users
  authenticated :user do
    root to: "tasks#index", as: :authenticated_root
  end

  devise_for :users
  resources :tasks do
    collection do
      get :pending
      get :completed
    end
    member do
      patch :complete
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
