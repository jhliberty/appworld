Appworld::Application.routes.draw do

  resources :sessions
  resources :users
  
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  root :to => "pages#home"
end
