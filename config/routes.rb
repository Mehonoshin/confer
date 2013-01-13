require "multidomain"
Confer::Application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  constraints(Multidomain) do
    resources :participants do
      member do
        put :approve
      end
    end
    resources :reports do
      member do
        put :approve
      end
    end
    resources :news_articles, path: "news"
    resources :organizers, only: [:index, :new, :destroy, :create]
    resources :feedbacks, only: [:index, :show, :destroy, :create]
    match '/feed' => 'news_items#feed',
      as: :feed,
      defaults: { format: 'atom' }
    get "/contacts" => "projects#contacts", as: :contacts
    get "/" => "projects#index"
  end

  namespace :admin do
    resources :users do
      resources :logs, only: [:index]
      member do
        put :make_admin
        put :make_user
        put :confirm
      end
    end
    resources :conferences do
      resources :logs, only: [:index]
      member do
        put :approve
      end
    end
    get "logs" => "logs#index", as: :logs
  end

  resources :users
  resources :conferences

  get "/about" => "main#about", as: :about
  root :to => 'main#index'
end
