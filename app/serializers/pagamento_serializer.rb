class PagamentoSerializer < ActiveModel::Serializer
  attributes :id, :qrcode, :dia_vencimento, :valor, :data_pagamento, :status, :month_id, :month
  has_one :user
  has_one :month
  # def attributes(*_args)
  #   byebug
  # end
end
