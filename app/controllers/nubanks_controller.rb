class NubanksController < ApplicationController
  require 'httparty'

  before_action :set_nubank, only: %i[show update destroy]

  # GET /nubanks
  def index
    @nubanks = Nubank.all

    render json: @nubanks
  end

  # GET /nubanks/1
  def show
    render json: @nubank
  end

  # POST /nubanks
  def create
    @nubank = Nubank.new(nubank_params)

    if @nubank.save
      render json: @nubank, status: :created, location: @nubank
    else
      render json: @nubank.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /nubanks/1
  def update
    if @nubank.update(nubank_params)
      render json: @nubank
    else
      render json: @nubank.errors, status: :unprocessable_entity
    end
  end

  # DELETE /nubanks/1
  def destroy
    @nubank.destroy
  end

  def processed_transaction
    last_processed_transaction = Config.last.last_processed_transaction
    # uri = URI("https://ctis-api-lrzbakfyzq-uc.a.run.app/process_all_transactions?last_processed_transaction=#{last_processed_transaction}")
    # response = Net::HTTP.get(uri)
    # resposta = JSON.parse(response)
    resposta = {
      'processed_transactions' => [
        { 'aluno_pagamento_id' => 3, 'status' => 'efetuado', 'data_pagamento' => '2023-03-24T00:00:00+00:00',
          'transaction_id' => '641d3c9b-2a80-453e-b7f1-18dbbf68d768' }, { 'aluno_pagamento_id' => 4, 'status' => 'efetuado', 'data_pagamento' => '2023-03-24T00:00:00+00:00', 'transaction_id' => '641d3be0-4281-4f26-ac6a-7d0297f0a6c5' }
      ], 'last_processed_transaction' => '641e3760-19d5-4e5f-a1b1-263be552f471'
    }
    # Colocar depois num block de try catch
    Config.create(last_processed_transaction: resposta['last_processed_transaction'])

    resposta['processed_transactions'].each do |transaction|
      Nubank.create(
        pagamento_id: transaction['aluno_pagamento_id'],
        status: transaction['status'],
        data_pagamento: transaction['data_pagamento'],
        transaction_id: transaction['transaction_id']
      )

      pagamento = Pagamento.find(transaction['aluno_pagamento_id'])

      pagamento.update(
        status: 'pago',
        data_pagamento: transaction['data_pagamento'],
        tipo: 'pix'
      )
    end
  end

  def qrcode
    # p 'entrei'
    # uri = 'https://ctis-api-lrzbakfyzq-uc.a.run.app/generate_payment_qrcode'
    # uri2 = 'http://127.0.0.1:3000/turmas'
    # headers = {
    #   'Content-Type' => 'application/json'
    # }

    # body = {
    #   pagamentos: [
    #     {
    #       aluno_pagamento_id: 1,
    #       valor_mensalidade: 1
    #     }
    #   ]
    # }
    # t = body.to_json
    # byebug
    # response = HTTParty.post(uri, headers:, body: body.to_json)

    # byebug
    # puts response.body
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_nubank
    @nubank = Nubank.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def nubank_params
    params.require(:nubank).permit(:pagamento_id, :status, :data_pagamento, :transaction_id)
  end
end
