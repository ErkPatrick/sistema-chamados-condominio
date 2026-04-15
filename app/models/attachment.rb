class Attachment < ApplicationRecord
  belongs_to :ticket
  has_one_attached :file

  validate :file_presence

  def file_presence
    errors.add(:file, " deve ser anexado") unless file.attached?
  end
end