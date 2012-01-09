Appworld::Application.routes.draw do

  resources :sessions
  resources :users

  root :to => "pages#home"
end
