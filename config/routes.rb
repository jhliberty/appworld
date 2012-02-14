Appworld::Application.routes.draw do
  
  resources :charges
  resources :uploads
  resources :sessions
  resources :users
  
  match "/uploads/new/:charge_id", :to => "uploads#new", :as => "up_app"
  match '/dashboard', :to => "dashboard#index"
  match '/uploads/delete/:id', :to => "uploads#destroy",  :as => "delete"
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  root :to => "pages#home"
end
