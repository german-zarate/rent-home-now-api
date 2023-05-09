Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :properties, only: %i[index show create update destroy]
      resources :users, only: %i[index show update destroy]
      post 'auth/sign_in', to: 'authentication#sign_in'
      post 'auth/sign_up', to: 'users#create'
      get 'auth/me', to: 'authentication#current_user'
    end
  end
  match '*unmatched_route', to: 'application#not_found', via: :all
end
