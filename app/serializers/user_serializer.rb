class UserSerializer < ActiveModel::Serializer
  has_many :turmas

  def attributes(*args)
    object.attributes.symbolize_keys
  end
end
