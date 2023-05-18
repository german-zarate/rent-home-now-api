Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :categories, only: %i[index show]
      resources :properties, only: %i[index show create update destroy]
      resources :reservation_criterias, only: %i[index show create update destroy]
      resources :addresses, only: %i[create update destroy]
      resources :users, only: %i[index show update destroy]
      resources :reservations, only: %i[index show create update destroy]
      post 'auth/sign_in', to: 'authentication#sign_in'
      post 'auth/sign_up', to: 'users#create'
      get 'auth/me', to: 'authentication#current_user'
    end
  end
  match '*unmatched_route', to: 'application#not_found', via: :all
end
