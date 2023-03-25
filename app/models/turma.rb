class Turma < ApplicationRecord
  validates :sede, :dia, :horario, :valor, :professor, presence: true
  has_many :turma_alunos, dependent: :destroy
  has_many :users, through: :turma_alunos
end
