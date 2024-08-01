Rails.application.routes.draw do
  get 'password_resets/new'
  resources :family_members
  resources :members
  root 'pages#home'
  resources :admins
  resources :addresses
  resources :locations

  
  get "sign_up" , to:"registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in" , to:"pages#home"
  post "sign_in", to: "pages#create"

  delete "logout", to: "pages#destroy"

  get "password", to: "passwords#edit" ,as: 'edit_password'
  patch "password", to: "passwords#update" , as: 'update_password'


  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"

  


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
