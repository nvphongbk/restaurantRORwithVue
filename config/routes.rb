Rails.application.routes.draw do
  root "home#index"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :import_data, only: %w[index create]
      resources :dishes
      resources :images, only: %w[create index]
      resources :categories do
        member do
          get :dishes
        end
      end
      resources :restaurants do
        member do
          get :categories
          get :menu, to: 'restaurants#all_categories'
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

