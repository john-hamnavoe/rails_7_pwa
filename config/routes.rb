Rails.application.routes.draw do

  resources :users
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/service-worker.js', to: 'service_workers/workers#index'
  get '/manifest.json', to: 'service_workers/manifests#index'
  root 'welcome#index'
end
