Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, defaults: {format: 'json'} do
      resources :reservation_criterias, only: [:index, :show, :create, :update, :destroy]
      resources :categories, only: [:index]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
