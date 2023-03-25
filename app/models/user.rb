# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable,
          :registerable,
          # :recoverable,
          # :rememberable,
          :validatable,
          # :trackable,
          authentication_keys: [:telefone]
  include DeviseTokenAuth::Concerns::User

  validates :telefone, presence: true, uniqueness: true
  validates :dia_vencimento, presence: true

  has_many :pagamentos, dependent: :destroy
  has_many :turma_alunos, dependent: :destroy
  has_many :turmas, through: :turma_alunos

  before_validation do
    self.uid = telefone if uid.blank?
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
