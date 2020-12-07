Rails.application.routes.draw do

  root "home#index"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :dishes
      resources :categories
      resources :restaurants do
        member do
          get :categories
        end
      end
      resources :signin
      resources :users
    end
  end
  match '/*path', to: 'home#index', format: false, via: :get
end

