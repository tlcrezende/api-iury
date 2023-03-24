class UserSerializer < ActiveModel::Serializer
  has_many :turma

  def attributes(*args)
    object.attributes.symbolize_keys
  end
end