Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :dishes
      resources :categories
      resources :restaurants
    end
  end
  
  root "home#index"


end
