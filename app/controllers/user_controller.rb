class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    users = User.all
    render json: users, status: 200
  end

  def create
    User.create!(params.permit(:telefone, :password, :apelido))
  end

  def show
    if params['id'].present?
      user = User.find(params['id'])
      render json: user, status: 200 unless user.nil?
      render json: { msg: 'usuário não encontrado' }, status: 404 if user.nil?
    else
      render json: { msg: 'parametro id faltando' }, status: 404
    end
  end

  def update
    current_user.update(
      params.permit(
        :name, :data_nascimento, :email, :tipo_sanguineo, :tamanho_camisa, :tamanho_pe, :desconto,
        :contato_emergencia_nome, :contato_emergencia_telefone, :responsavel_nome, :responsavel_parentesco,
        :responsavel_telefone, :endereco, :cep, :foto_id, :data_inicio, :alergias, :expo_push_token, :vencimento
      )
    )

    render json: 'usuário atualizado', status: 200
  end
end
