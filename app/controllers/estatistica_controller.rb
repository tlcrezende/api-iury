class EstatisticaController < ApplicationController
  def index
    # Total de receita por mês
    receita = Pagamento.group(:month_id, :status).sum(:valor)

    # de query consigo tirar receita máxima, receira paga, receita atrasada (somente aquele que já venceu)
    receita_maxima = receita.values.sum
    receita_pago = receita.select { |key, _| key[1] == 'pago' }.values.sum
    receita_atrasada = receita.select { |key, _| key[1] == 'pendente' }.values.sum

    query = Pagamento.joins(:month).group(:month_id, :status, :mes, :ano, :tipo).order(:month_id).sum(:valor)
    primeiro_mes = query.keys.first[0]
    ultimo_mes = query.keys.last[0]
    resultado = []
    (primeiro_mes.to_i..ultimo_mes.to_i).each do |mes|
      next unless query.keys.filter { |key| key[0] == mes }.present?

            resultado << {
        mes: query.filter { |key| key[0] == mes }.keys[0][2],
        ano: query.filter { |key| key[0] == mes }.keys[0][3],
        atrasado: query.filter { |key| key[0] == mes }.filter { |key| key[1] == 'pendente' }.values.sum,
        pago: {
          total: query.filter { |key| key[0] == mes }.filter { |key| key[1] == 'pago' }.values.sum,
          pix: query.filter do |key|
                 key[0] == mes
               end.filter { |key| key[1] == 'pago' }.filter { |key| key[4] == 'pix' }.values.sum,
          cartao: query.filter do |key|
                    key[0] == mes
                  end.filter { |key| key[1] == 'pago' }.filter { |key| key[4] == 'cartao' }.values.sum,
          dinheiro: query.filter do |key|
                      key[0] == mes
                    end.filter { |key| key[1] == 'pago' }.filter { |key| key[4] == 'dinheiro' }.values.sum
        }

      }
    end

    # ultimo_mes
    # soma = 0
    # resultado = []
    # {
    #   mes:
    #   ano:
    #   pago: {
    #     total:
    #     pix:
    #     cartao:
    #     dinheiro:
    #   }
    #   atrasado_total:
    # }
    # query.each do |key, sum|
    #   if key[0] == primeiro_mes
    #     # if key[2] == 'pago' && key[5] != nil

    #     # end
    #   else

    #   end

    # end
    # total pago por mes em pix, dinheiro, cartão
    # render json: query.filter { |key, _value| key[4] == 'dinheiro' && key[0] == 14 }.values
    render json: resultado
  end
end
