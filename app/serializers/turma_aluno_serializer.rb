class TurmaAlunoSerializer < ActiveModel::Serializer
  # attributes :id, :status, :turma
  attributes :id, :status, :turma
  has_one :turma
  has_one :user
end
