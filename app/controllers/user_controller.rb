class UserController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :authenticate_user!, except: :create

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    byebug
    @user = User.create!(params.permit(:telefone, :password, :apelido))
    # render json: @user, status: :created if @user.save
    # render json: @user.errors, status: :unprocessable_entity unless @user.save
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :data_nascimento, :email, :tipo_sanguineo, :tamanho_camisa, :tamanho_pe, :desconto,
                  :contato_emergencia_nome, :contato_emergencia_telefone, :responsavel_nome, :responsavel_parentesco,
                  :responsavel_telefone, :endereco, :cep, :foto_id, :data_inicio, :alergias, :expo_push_token, :vencimento)
  end
end
