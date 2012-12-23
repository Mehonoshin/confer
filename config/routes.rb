Confer::Application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users
    resources :conferences
  end

  resources :users
  resources :conferences

  root :to => 'main#index'
end
