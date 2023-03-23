class PagamentoSerializer < ActiveModel::Serializer
  attributes :id, :qrcode, :dia_vencimento, :valor, :data_pagamento, :status
  has_one :turma
  has_one :user
  has_one :month
end
