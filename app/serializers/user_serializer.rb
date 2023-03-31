class UserSerializer < ActiveModel::Serializer
  # has_many :turmas, serializer: TurmaSemAlunoSerializer
  # has_many :turma_alunos
  # has_many :pagamentos

  def attributes(*_args)
    # object.turma_alunos = object.turma_alunos.filter { |turma_aluno| turma_aluno.status == 'inativo' }
    # object.turmas = object.turma_alunos.filter { |turma_aluno| turma_aluno.status == 'inativo' }.map { |ta| ta.turma }
    # object.attributes.symbolize_keys
    {
      **object.attributes.symbolize_keys,
      turmas: object.turma_alunos.filter { |turma_aluno| turma_aluno.status == 'ativo' }.map(&:turma),
      pagamentos: object.pagamentos.map { |pagamento| { **pagamento.attributes.symbolize_keys, mes: pagamento.month.mes } }
    }
  end
end
