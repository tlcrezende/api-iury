class TurmasSerializer < ActiveModel::Serializer
  has_many :user

  def attributes(*args)
    # byebug
    object.attributes.symbolize_keys
  end
end
