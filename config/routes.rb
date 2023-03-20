Rails.application.routes.draw do
  root to: 'reports#index'

  get 'reports/index'
  
  resource :session, only: %i[new create destroy]
  
  # get 'generator/create'

  # resource :generator, only: %i[create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
