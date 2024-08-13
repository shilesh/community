Rails.application.routes.draw do


  root 'pages#home'

  resources :pages
  resources :family_members
  resources :members
  resources :admins
  resources :addresses
  resources :locations

  resources :admins do 
    member do
      patch 'change_password', to: 'admins#change_password', as: :change_password
    end 
  end
  get 'profile', to: 'admins#show', as: :profile


  get 'login', to: 'login#new', as: :new_login
  post 'login', to: 'login#create', as: :login
  delete 'logout', to: 'login#destroy', as: :logout



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end