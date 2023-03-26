class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  # before_action :authenticate_user!, except: :create

  def index
    @users = User.all.includes(%i[turmas turma_alunos])
    # @users = User.left_joins(:turma_aluno).where(perfil: 'aluno').group('users.id').select(
    #   'users.*',
    #   "array_agg(json_build_object(
    #     ''
    #   ))")
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.create!(params.permit(:telefone, :apelido, :responsavel_nome, :responsavel_telefone, :data_inicio,
                                       :dia_vencimento))
    @user.password = Time.zone.now
    @user.save
    render json: { aluno_id: @user.id }
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

  # ALUNO
  def aluno_info
    render json: current_user
  end

  def aluno_update
    if current_user.update(user_params)
      render json: current_user
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :data_nascimento, :email, :tipo_sanguineo, :tamanho_camisa, :tamanho_pe, :desconto, :apelido,
                  :contato_emergencia_nome, :contato_emergencia_telefone, :responsavel_nome, :responsavel_parentesco,
                  :responsavel_telefone, :endereco, :cep, :foto_id, :data_inicio, :alergias, :expo_push_token, :dia_vencimento)
  end
end
