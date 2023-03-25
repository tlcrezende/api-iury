class PagamentosController < ApplicationController
  before_action :set_pagamento, only: %i[show update destroy]

  def index
    pagamentos = Pagamento.all
    render json: pagamentos, status: 200
  end

  def show
    render json: @pagamento
  end

  def create
    @pagamento = Pagamento.new(pagamento_params)

    if @pagamento.save
      render json: @pagamento, status: :created, location: @pagamento
    else
      render json: @pagamento.errors, status: :unprocessable_entity
    end
  end

  def update
    if @pagamento.update(pagamento_params)
      render json: @pagamento
    else
      render json: @pagamento.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @pagamento.destroy
  end

  def teste
    p 'entrei no teste'
    NubankService.process
  end


  # ALUNO
  def aluno_index
    render json: current_user.pagamentos.all
  end

  private

  def set_pagamento
    @pagamento = Pagamento.find(params[:id])
  end

  def pagamento_params
    params.require(:pagamento).permit(:turma_id, :user_id, :qrcode, :dia_vencimento, :valor, :month_id,
                                      :data_pagamento, :status)
  end
end
