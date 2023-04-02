class NubanksController < ApplicationController
  # require 'httparty'

  def processed_transaction
    nubank = NubankService.connect_process

    Config.create(last_processed_transaction: nubank['last_processed_transaction'])

    nubank['processed_transactions'].each do |transaction|
      Nubank.create(
        pagamento_id: transaction['aluno_pagamento_id'],
        status: transaction['status'],
        data_pagamento: transaction['data_pagamento'],
        transaction_id: transaction['transaction_id']
      )

      pagamento = Pagamento.find_by(id: transaction['aluno_pagamento_id'])

      pagamento.update(
        status: 'pago',
        data_pagamento: transaction['data_pagamento'],
        tipo: 'pix'
      ) if pagamento.present?
    end

    render json: "#{nubank['processed_transactions'].count} transações processadas com sucesso!"
  end

  # melhorias: fazer blocos de catch try, fazer tabela de logs de requests
  def qrcode
    users = User.joins(:turma_alunos)
                .joins(:turmas)
                .select('users.id, users.dia_vencimento, SUM(turmas.valor) as total_valor')
                .where(turma_alunos: { status: 'ativo' })
                .group('users.id')

    mes = Month.find_by(pagamento_gerado: false)

    pagamentos = users.map do |user|
      Pagamento.create!(
        user_id: user.id,
        dia_vencimento: user.dia_vencimento,
        valor: user.total_valor,
        month_id: mes.id,
        status: 'gerado'
      )
    end

    mes.update(pagamento_gerado: true)
    
    qrcode = { pagamentos: pagamentos.map { |pagamento| { aluno_pagamento_id: pagamento.id, valor_mensalidade: 1 } } }

    nubank_qrcodes = NubankService.coneect_qrcode(qrcode)

    nubank_qrcodes['pagamentos'].each do |qrcode|
      pagamento = Pagamento.find(qrcode['id'])
      pagamento.update(qrcode: qrcode['qrcode'])
    end

    render json: "Foram gerados #{pagamentos.size} pagamentos para o mês de #{mes.mes} de #{mes.ano} com sucesso"
  end
end