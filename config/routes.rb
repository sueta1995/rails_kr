Rails.application.routes.draw do
  root to: 'reports#index'

  get 'reports/index'
  post 'reports/create' => 'reports#create'
  
  resource :session, only: %i[new create destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
