Rails.application.routes.draw do
  resources :nubanks
  resources :turma_alunos
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :pagamentos
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'
  patch '/users/:id', to: 'users#update'

  get '/turmas', to: 'turmas#index'
  get '/turmas/:id', to: 'turmas#show'
  post '/turmas', to: 'turmas#create'
  patch '/turmas/:id', to: 'turmas#update'

  get '/process', to: 'pagamentos#teste'
end
