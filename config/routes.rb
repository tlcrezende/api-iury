Rails.application.routes.draw do
  resources :turma_alunos
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :pagamentos
  get '/users', to: 'user#index'
  get '/users/:id', to: 'user#show'
  post '/users', to: 'user#create'
  patch '/users/:id', to: 'user#update'

  get '/turmas', to: 'turma#index'
  get '/turmas/:id', to: 'turma#show'
  post '/turmas', to: 'turma#create'
  patch '/turmas/:id', to: 'turma#update'
end
