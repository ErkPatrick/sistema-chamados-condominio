class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, collaborator: 1, resident: 2 }

  has_many :unit_users, dependent: :destroy
  has_many :units, through: :unit_users  # Acessa as unidades passando pela tabela unit_users
  has_many :tickets, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :role, presence: true
end