Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/user', to: 'user#index'
  get '/user/:id', to: 'user#show'
  post '/user', to: 'user#update'

  get '/turma', to: 'turma#index'
  get '/turma/:id', to: 'turma#show'
  post '/turma', to: 'turma#create'

  # Defines the root path route ("/")
  # root "articles#index"
end
