class TurmaAlunosController < ApplicationController
  before_action :set_turma_aluno, only: %i[show update destroy]

  def index
    @turma_alunos = TurmaAluno.all

    render json: @turma_alunos
  end

  def show
    render json: @turma_aluno
  end

  def create
    @turma_aluno = TurmaAluno.new(turma_aluno_params)

    if @turma_aluno.save
      render json: @turma_aluno, status: :created, location: @turma_aluno
    else
      render json: @turma_aluno.errors, status: :unprocessable_entity
    end
  end

  def update
    if @turma_aluno.update(turma_aluno_params)
      render json: @turma_aluno
    else
      render json: @turma_aluno.errors, status: :unprocessable_entity
    end
  end

  def update_all
    TurmaAluno.where(turma_id: params[:turma_id]).destroy_all
    params[:user_id].each do |user|
      TurmaAluno.create(
        turma_id: params[:turma_id],
        user_id: user,
        status: 'ativo'
      )
    end
    render json: ''
  end

  def destroy
    @turma_aluno.destroy
  end

  private

  def set_turma_aluno
    @turma_aluno = TurmaAluno.find(params[:id])
  end

  def turma_aluno_params
    params.require(:turma_aluno).permit(:turma_id, :user_id, :status)
  end
end
