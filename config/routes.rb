Confer::Application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users do
      member do
        put :make_admin
        put :make_user
        put :confirm
      end
    end
    resources :conferences do
      member do
        put :approve
      end
    end
  end

  resources :users
  resources :conferences

  root :to => 'main#index'
end
