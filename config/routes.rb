# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :import_data, only: %w[index create]
      resources :dishes do
        member do
          post :change_active
        end
      end
      resources :images, only: %w[create index]
      resources :messages

      resources :categories do
        member do
          get :dishes
          post :change_active
        end
      end
      resources :cooking_methods do
        member do
          post :change_active
        end
      end
      resources :main_ingredients do
        member do
          post :change_active
        end
      end
      resources :restaurants do
        member do
          get :categories
          get :menus
        end
      end
      resources :users
    end
  end

  devise_for :users,
             defaults: { format: :json },
             path: '',
             path_names: {
               sign_in: 'api/v1/signin', only: %w[create],
               sign_out: 'api/v1/signout',
               registration: 'api/v1/signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }

  match '/*path', to: 'home#index', format: false, via: :get
end
