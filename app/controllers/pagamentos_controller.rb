class PagamentosController < ApplicationController
  before_action :set_pagamento, only: %i[show update destroy aluno_show]
  # before_action :authenticate_user!
  before_action :atualizar_status, only: %i[index aluno_index]

  def index
    pagamentos = Pagamento.all
    render json: pagamentos, status: 200
  end

  def show
    render json: @pagamento
  end

  def create
    if params[:dia_vencimento]
      dia_vencimento = Date.parse(params[:dia_vencimento]).day
      mes = Date.parse(params[:dia_vencimento]).month
      ano = Date.parse(params[:dia_vencimento]).year
      month = Month.where(mes_numero: mes, ano: ano.to_s).first
      @pagamento = Pagamento.create(user_id: params[:user_id], 
        valor: params[:valor],
        status: "gerado", 
        dia_vencimento:, 
        month_id: month.id)
        
      if @pagamento.save
        qrcode = { pagamentos: [] }
        qrcode[:pagamentos] << {
          aluno_pagamento_id: @pagamento.id,
          valor_mensalidade: @pagamento.valor
        }
          
        uri = 'https://ctis-api-lrzbakfyzq-uc.a.run.app/generate_payment_qrcode'
        headers = { 'Content-Type' => 'application/json' }
        response = HTTParty.post(uri, headers:, body: qrcode.to_json)

        nubank_qrcodes = JSON.parse(response.body)

        @pagamento.update(qrcode: nubank_qrcodes['pagamentos'][0]['qrcode'])

        render json: @pagamento, status: :created, location: @pagamento
      else
        render json: @pagamento.errors, status: :unprocessable_entity
      end
    else
      render json: 'dia_vencimento faltando', status: :unprocessable_entity
    end
  end

  def update
    if params[:valor] != @pagamento.valor
      qrcode = { pagamentos: [] }
        qrcode[:pagamentos] << {
        aluno_pagamento_id: @pagamento.id,
        valor_mensalidade: @pagamento.valor
      }
        
      uri = 'https://ctis-api-lrzbakfyzq-uc.a.run.app/generate_payment_qrcode'
      headers = { 'Content-Type' => 'application/json' }
      response = HTTParty.post(uri, headers:, body: qrcode.to_json)

      nubank_qrcodes = JSON.parse(response.body)

      @pagamento.update(qrcode: nubank_qrcodes['pagamentos'][0]['qrcode'])
      @pagamento.update(pagamento_params)
    end

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
    render json: current_user.pagamentos.joins(:month).select(
      :id, :data_pagamento, :status, 'months.mes', 'months.ano', 'months.id as mes_id'
    ), adapter: nil
  end

  def aluno_show
    render json: @pagamento.attributes.merge(@pagamento.month.attributes), adapter: nil
  end

  private

  def set_pagamento
    @pagamento = Pagamento.find(params[:id])
  end

  def pagamento_params
    params.require(:pagamento).permit(:user_id, :dia_vencimento, :valor, :month_id,
                                      :data_pagamento, :status)
  end

  def atualizar_status
    pagamentos_status_gerado = Pagamento.where(status: 'gerado')
    pagamentos_status_gerado.each do |pagamento|
      vencimento = "#{pagamento.month.mes_numero}/#{pagamento.dia_vencimento}/#{pagamento.month.ano}".to_date
      pagamento.update(status: 'pendente') if Time.zone.now > vencimento
    end
  end
end
