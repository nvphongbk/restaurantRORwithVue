# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :import_data, only: %w[index create]
      resources :dishes do
        member do
          post :change_active
          delete :destroy_select
        end
      end
      resources :images, only: %w[create index destroy]
      resources :messages

      resources :categories do
        member do
          get :dishes
          post :change_active
          post :change_display_home
        end
      end
      resources :cooking_methods do
        member do
          post :change_active
          get :dishes
        end
      end
      resources :main_ingredients do
        member do
          post :change_active
          get :dishes
        end
      end
      resources :restaurants do
        collection do
          get :guest_index
        end

        member do
          get :guest_dishes
          get :guest_restaurant_info
          get :categories
          get :cooking_methods
          get :main_ingredients
        end
      end
      resources :users do
        collection do
          get :get_info
          post :change_restaurant_default
        end
      end
      resources :logos, only: %w[create update index]
      resources :backgrounds, only: %w[create update index]
      resources :menus do
        member do
          post :change_active
        end
      end
    end
  end

  devise_for :users,
             defaults: {format: :json},
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
