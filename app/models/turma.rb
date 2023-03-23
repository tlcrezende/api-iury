class Turma < ApplicationRecord
  validates :sede, :dia, :horario, :valor, :professor, presence: true
  has_many :pagamento
  has_many :turma_aluno, dependent: :destroy
end
