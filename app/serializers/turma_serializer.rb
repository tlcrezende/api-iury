class TurmaSerializer < ActiveModel::Serializer
  # has_many :user

  def attributes(*_args)
    {
      id: object.id,
      sede: object.sede,
      dia: object.dia,
      horario: object.horario,
      professor: object.professor,
      valor: object.valor,
      alunos: object.turma_alunos.filter { |ta| ta.status == 'ativo' }.map { |ta| { name: ta.user[:name], apelido: ta.user[:apelido] } }
    }
  end
end
