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
    match '/feed' => 'news_items#feed',
      as: :feed,
      defaults: { format: 'atom' }
    get "/" => "projects#index"
  end

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

  get "/about" => "main#about", as: :about
  root :to => 'main#index'
end
