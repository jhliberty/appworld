Appworld::Application.routes.draw do

  get "uploads/new"

  get "dashboard/index"
  
  resources :uploads, :only => [:new, :create, :edit]
  resources :sessions
  resources :users
  
  match '/dashboard', :to => "dashboard#index"
  # match 'dashboard/upload', :to => "dashboard#upload", :as => "upload"
  match 'dashboard/delete', :to => "dashboard#delete",  :as => "delete"
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  root :to => "pages#home"
end
