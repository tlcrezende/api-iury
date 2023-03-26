class TurmasController < ApplicationController
  before_action :set_turma, only: %i[show update destroy]

  def index
    turmas = Turma.all.select(:id, :sede, :dia, :horario, :professor)
    render json: turmas, status: 200, adapter: nil
  end

  def show
    render json: Turma.find(params[:id])
    # if params[:id]
    #   turma = Turma.find(params[:id])
    #   render json: turma, status: 200 unless turma.nil?
    #   render json: { msg: 'usuário não encontrado' }, status: 404 if turma.nil?
    # else
    #   render json: { msg: 'parametro id faltando' }, status: 404
    # end
  end

  def create
    t = Turma.create!(params.permit(:sede, :dia, :horario, :professor, :valor))
    render json: { turma_id: t.id }, status: 200
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
