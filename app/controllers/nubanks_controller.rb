class NubanksController < ApplicationController
  require 'httparty'

  def processed_transaction
    last_processed_transaction = Config.last.last_processed_transaction
    uri = URI("https://ctis-api-lrzbakfyzq-uc.a.run.app/process_all_transactions?last_processed_transaction=#{last_processed_transaction}")
    response = Net::HTTP.get(uri)
    resposta = JSON.parse(response)

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

    render json: "#{resposta['processed_transactions'].count} transações processadas com sucesso!"
  end

  # melhorias: fazer blocos de catch try, fazer tabela de logs de requests
  def qrcode
    users = User.joins(:turma_alunos)
                .joins(:turmas)
                .select('users.id, users.dia_vencimento, SUM(turmas.valor) as total_valor')
                .where(turma_alunos: { status: 'ativo' })
                .group('users.id')

    qrcode = { pagamentos: [] }

    mes = Month.where(pagamento_gerado: false).first

    qnt_pagamentos = 0
    users.each do |user|
      pagamento = Pagamento.create!(
        user_id: user.id,
        dia_vencimento: user.dia_vencimento,
        valor: user.total_valor,
        month_id: mes.id,
        status: 'gerado'
      )

      qrcode[:pagamentos] << {
        aluno_pagamento_id: pagamento.id,
        valor_mensalidade: 1
      }

      qnt_pagamentos += 1
    end

    mes.update(pagamento_gerado: true)

    uri = 'https://ctis-api-lrzbakfyzq-uc.a.run.app/generate_payment_qrcode'
    headers = { 'Content-Type' => 'application/json' }
    response = HTTParty.post(uri, headers:, body: qrcode.to_json)

    nubank_qrcodes = JSON.parse(response.body)

    nubank_qrcodes['pagamentos'].each do |qrcode|
      pagamento = Pagamento.find(qrcode['id'])
      pagamento.update(
        qrcode: qrcode['qrcode']
      )
    end

    render json: "Foram gerados #{qnt_pagamentos} pagamentos para o mês de #{mes.mes} de #{mes.ano} com sucesso"
  end
end
