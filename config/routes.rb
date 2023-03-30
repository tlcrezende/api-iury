Rails.application.routes.draw do
  get 'estatistica/index'
  resources :nubanks
  resources :turma_alunos
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :pagamentos
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'
  patch '/users/:id', to: 'users#update'

  get '/firebase', to: 'users#firebase'

  get '/turmas', to: 'turmas#index'
  get '/turmas/:id', to: 'turmas#show'
  post '/turmas', to: 'turmas#create'
  patch '/turmas/:id', to: 'turmas#update'

  scope :aluno, path: 'aluno' do
    get '/info', to: 'users#aluno_info'
    patch '', to: 'users#aluno_update'

    get '/pagamentos', to: 'pagamentos#aluno_index'
    get '/pagamentos/:id', to: 'pagamentos#aluno_show'
  end
  # Ex:- scope :active, -> {where(:active => true)}
  post '/processed_transaction', to: 'nubanks#processed_transaction'
  post '/qrcode', to: 'nubanks#qrcode'

  patch '/turma_alunos/update_all/:turma_id', to: 'turma_alunos#update_all'

  get '/estatisticas', to: 'estatistica#index'
end
