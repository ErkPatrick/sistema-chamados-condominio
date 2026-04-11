class User < ApplicationRecord
  has_secure_password  # Mecanismo nativo de autenticação do rails

  enum :role, { admin: 0, collaborator: 1, resident: 2 }

  has_many :unit_users, dependent: :destroy
  has_many :units, through: :unit_users  # Acessa as unidades passando pela tabela unit_users
  has_many :tickets, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }  # validação de formato de email
  validates :role, presence: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
end