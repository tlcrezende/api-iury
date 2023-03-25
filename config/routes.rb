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


  scope :aluno, path: 'aluno' do
    get '/info', to: 'users#info'
    get '/pagamentos', to: 'pagamentos#aluno_index'
  end
  # Ex:- scope :active, -> {where(:active => true)}
  get '/processed_transaction', to: 'nubanks#processed_transaction'
  post '/qrcode', to: 'nubanks#qrcode'
end
