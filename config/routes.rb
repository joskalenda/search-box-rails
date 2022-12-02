Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  unauthenticated do
    root "homes#index"
  end

  authenticated :user do
    root "articles#index", as: :authenticated_root
  end
  resources :caches
  resources :articles do
    collection do
      post :search
    end
  end
end
