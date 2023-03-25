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
      alunos: object.users.map { |user| { name: user[:name], apelido: user[:apelido] } }
    }
  end
end
