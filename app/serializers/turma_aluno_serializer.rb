class TurmaAlunoSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :turma
  has_one :user
end
