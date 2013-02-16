require "multidomain"
Confer::Application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  constraints(Multidomain) do
    scope module: "project" do
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
      resources :materials, only: [:index, :new, :create, :destroy] do
        member do
          put :approve
        end
      end

      resources :organizers, only: [:index, :new, :destroy, :create]
      resources :feedbacks, only: [:index, :show, :destroy, :create]

      resources :news_articles, path: "news"
      match '/feed' => 'news_items#feed',
        as: :feed,
        defaults: { format: 'atom' }

      resources :conferences, only: [:edit, :update]
      resources :pages, except: [:show]

      get "/settings" => "conferences#edit", as: :settings
      get "/contacts" => "feedbacks#new", as: :contacts

      get "/" => "projects#index"
      get "/:id" => "pages#show", as: :public_page
    end
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
