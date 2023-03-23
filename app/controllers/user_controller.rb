class UserController < ApplicationController
    before_action :authenticate_user!

    def index 
        users = User.all
        render json: users, status: 200
    end
    
    def show 
        if params['id'].present?
            user = User.find(params['id'])
            render json: user, status: 200 unless user.nil?
            render json: {msg: 'usuário não encontrado'}, status: 404 if user.nil?
        else
            render json: {msg: 'parametro id faltando'}, status: 404
        end
    end
    
    def update 
        current_user.update(
            name: params['name'].present? ? params['name'] : user_info.name,
            data_nascimento: params['data_nascimento'] ? params['data_nascimento'] : user_info.data_nascimento,
            email: params['email'] ? params['email'] : user_info.email,
            tipo_sanguineo: params['tipo_sanguineo'] ? params['tipo_sanguineo'] : user_info.tipo_sanguineo,
            tamanho_pe: params['tamanho_pe'] ? params['tamanho_pe'] : user_info.tamanho_pe,
            tamanho_camisa: params['tamanho_camisa'] ? params['tamanho_camisa'] : user_info.tamanho_camisa,
            contato_emergencia_nome: params['contato_emergencia_nome'] ? params['contato_emergencia_nome'] : user_info.contato_emergencia_nome,
            contato_emergencia_telefone: params['contato_emergencia_telefone'] ? params['contato_emergencia_telefone'] : user_info.contato_emergencia_telefone,
            responsavel_nome: params['responsavel_nome'] ? params['responsavel_nome'] : user_info.responsavel_nome,
            responsavel_telefone: params['responsavel_telefone'] ? params['responsavel_telefone'] : user_info.responsavel_telefone,
            responsavel_parentesco: params['responsavel_parentesco'] ? params['responsavel_parentesco'] : user_info.responsavel_parentesco,
            endereco: params['endereco'] ? params['endereco'] : user_info.endereco,
            cep: params['cep'] ? params['cep'] : user_info.cep,
            foto_id: params['foto_id'] ? params['foto_id'] : user_info.foto_id,
            data_inicio: params['data_inicio'] ? params['data_inicio'] : user_info.data_inicio,
            alergias: params['alergias'] ? params['alergias'] : user_info.alergias,
            expo_push_token: params['expo_push_token'] ? params['expo_push_token'] : user_info.expo_push_token,
            vencimento: params['vencimento'] ? params['vencimento'] : user_info.vencimento,
            desconto: params['desconto'] ? params['desconto'] : user_info.desconto
        )

        render json: 'usuário atualizado', status: 200
    end
end
