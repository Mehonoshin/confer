Confer::Application.routes.draw do
  devise_for :users

  resources :users
  resources :conferences

  root :to => 'main#index'
end
