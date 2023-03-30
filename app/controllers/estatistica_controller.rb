class EstatisticaController < ApplicationController
  def index
    # Total de receita por mês
    receita = Pagamento.group(:month_id, :status).sum(:valor)

    # de query consigo tirar receita máxima, receira paga, receita atrasada (somente aquele que já venceu)
    receita_maxima = receita.values.sum
    receita_pago = receita.select{|key, _| key[1] == 'pago'}.values.sum
    receita_atrasada = receita.select{|key, _| key[1] == 'pendente'}.values.sum

    query = Pagamento.joins(:month).group(:month_id, :status, :mes, :ano, :tipo).sum(:valor)
    resultado = []
    query.each do |key, sum|
      if key[2] == 'pago' && key[5] != nil
        
      end
      
    end
    # total pago por mes em pix, dinheiro, cartão

  end
end
