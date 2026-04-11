class TicketType < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :sla_hours, presence: true, numericality: { only_integer: true, greater_than: 0 }
end