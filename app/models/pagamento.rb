class Pagamento < ApplicationRecord
  audited

  belongs_to :user
  belongs_to :month
  has_many :nubanks, dependent: :destroy
end
