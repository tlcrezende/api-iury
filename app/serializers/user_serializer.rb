class UserSerializer < ActiveModel::Serializer
  has_many :turmas, serializer: TurmaSemAlunoSerializer
  has_many :pagamentos

  def attributes(*_args)
    object.attributes.symbolize_keys
  end
end
