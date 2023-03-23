Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/users', to: 'user#index'
  get '/users/:id', to: 'user#show'
  post '/users', to: 'user#create'
  patch '/users/:id', to: 'user#update'
  put '/users/:id', to: 'user#update'

  get '/turmas', to: 'turma#index'
  get '/turmas/:id', to: 'turma#show'
  post '/turmas', to: 'turma#create'

  # Defines the root path route ("/")
  # root "articles#index"
end
