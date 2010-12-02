Trolley::Application.routes.draw do
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
