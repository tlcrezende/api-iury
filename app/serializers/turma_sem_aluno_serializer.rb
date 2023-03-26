class TurmaSemAlunoSerializer < ActiveModel::Serializer
  # has_many :user

  def attributes(*_args)
    {
      id: object.id,
      sede: object.sede,
      dia: object.dia,
      horario: object.horario,
      professor: object.professor,
      valor: object.valor
    }
  end
end
