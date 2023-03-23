class TurmaController < ApplicationController


    def index
        turmas = Turma.all
        render json: turmas, status: 200
    end

    def show 
        if params['id'].present?
            user = Turma.find(params['id'])
            render json: user, status: 200 unless user.nil?
            render json: {msg: 'usuário não encontrado'}, status: 404 if user.nil?
        else
            render json: {msg: 'parametro id faltando'}, status: 404
        end
    end

    def create
        turma = Turma.new 

        turma.sede = params['sede'] if params['sede'].present?
        turma.dia = params['dia'] if params['dia'].present?
        turma.horario = params['horario'] if params['horario'].present?
        turma.professor = params['professor'] if params['professor'].present?
        turma.valor = params['valor'] if params['valor'].present?

        if turma.save 
            render json: 'turma criada com sucesso', status: 200 
        else
            render json: 'turma não criada', status: 400 
        end
    end
end
