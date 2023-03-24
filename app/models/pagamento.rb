class Pagamento < ApplicationRecord
  audited

  belongs_to :turma
  belongs_to :user
  belongs_to :month
end
