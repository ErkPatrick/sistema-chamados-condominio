class Ticket < ApplicationRecord
  belongs_to :unit
  belongs_to :user
  belongs_to :ticket_type
  belongs_to :ticket_status

  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :description, presence: true
  validates :opened_at, presence: true

  before_create :set_default_status
  before_create :set_opened_at
  before_save :set_closed_at

  private

  def set_default_status
    default_status = TicketStatus.find_by(is_default: true)
    self.ticket_status = default_status if default_status  # proteção caso não haja um status padrão definido
  end

  def set_opened_at
    self.opened_at = Time.current
  end

  def set_closed_at
    if ticket_status&.is_final? && closed_at.nil?
      self.closed_at = Time.current
    end
  end
end