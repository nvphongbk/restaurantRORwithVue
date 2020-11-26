Rails.application.routes.draw do
  root "home#index"
  namespace :api do
    namespace :v1 do
      resources :dishes
      resources :categories
      resources :restaurants
    end
  end
  match '/*path', to: 'home#index', format: false, via: :get
end
