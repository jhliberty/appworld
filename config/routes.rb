Appworld::Application.routes.draw do

  get "dashboard/index"

  resources :sessions
  resources :users
  
  match '/dashboard', :to => "dashboard#index"
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  root :to => "pages#home"
end
