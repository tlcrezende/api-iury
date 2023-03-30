class UserSerializer < ActiveModel::Serializer
  # has_many :turmas, serializer: TurmaSemAlunoSerializer
  has_many :turma_alunos
  has_many :pagamentos

  def attributes(*_args)
    object.turma_alunos = object.turma_alunos.filter { |turma_aluno| turma_aluno.status == 'ativo' }
    object.attributes.symbolize_keys
  end
end
