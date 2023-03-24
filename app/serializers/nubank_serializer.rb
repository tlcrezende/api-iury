class NubankSerializer < ActiveModel::Serializer
  attributes :id, :status, :data_pagamento, :transaction_id
  has_one :pagamento
end
