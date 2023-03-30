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
    turma_alunos = TurmaAluno.where(turma_id: params[:turma_id], status: 'ativo')
    turma_atual = []
    turma_atualizacao = params[:user_id]

    turma_alunos.each { |aluno| turma_atual << aluno.user_id }

    alunos_entraram = turma_atualizacao - turma_atual
    alunos_sairam = turma_atual - turma_atualizacao

    alunos_entraram.each do |entrou|
      TurmaAluno.create(
        turma_id: params[:turma_id],
        user_id: entrou,
        status: 'ativo'
      )
    end

    turma_alunos.each do |aluno|
      next unless alunos_sairam.include?(aluno.user_id)

      aluno.update(
        status: 'inativo'
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
