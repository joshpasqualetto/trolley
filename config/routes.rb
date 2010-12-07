Trolley::Application.routes.draw do
  devise_for :users
  resources :users

  resources :assets do
    collection do
      match "search", :as => :search
    end

    member do
      get "download", :as => :download
    end
  end

  root :to => "assets#index"
end
