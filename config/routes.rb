Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :categories, only: %i[index show]
      resources :properties, only: %i[index show create update destroy]
      resources :reservation_criterias, only: %i[index show create update destroy]
      resources :addresses, only: %i[create update destroy]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
