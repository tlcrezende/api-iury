class TurmaController < ApplicationController
  before_action :set_turma, only: %i[show update destroy]

  def index
    turmas = Turma.all
    render json: turmas, status: 200
  end

  def show
    if params[:id]
      user = Turma.find(params[:id])
      render json: user, status: 200 unless user.nil?
      render json: { msg: 'usuário não encontrado' }, status: 404 if user.nil?
    else
      render json: { msg: 'parametro id faltando' }, status: 404
    end
  end

  def create
    Turma.create!(params.permit(:sede, :dia, :horario, :professor, :valor))
    render json: 'turma criada com sucesso', status: 200
  end

  def update
    if @turma.update(turma_params)
      render json: @turma
    else
      render json: @turma.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @turma.destroy
  end

  private

  def set_turma
    @turma = Turma.find(params[:id])
  end

  def turma_params
    params.permit(:id, :sede, :dia, :horario, :professor, :valor)
  end
end
