FactoryBot.define do
  factory :pagamento do
    turma { nil }
    user { nil }
    qrcode { "MyString" }
    dia_vencimento { 1 }
    valor { 1.5 }
    month { nil }
    data_pagamento { "2023-03-23 14:22:25" }
    status { "MyString" }
  end
end
