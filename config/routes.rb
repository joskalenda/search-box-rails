Rails.application.routes.draw do
  resources :caches
  resources :articles do
    collection do
      post :search
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
end
