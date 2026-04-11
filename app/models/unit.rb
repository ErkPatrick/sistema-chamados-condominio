class Unit < ApplicationRecord
  belongs_to :block

  has_many :unit_users, dependent: :destroy
  has_many :users, through: :unit_users
  has_many :tickets, dependent: :destroy

  validates :floor, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :identifier, presence: true, uniqueness: true
end