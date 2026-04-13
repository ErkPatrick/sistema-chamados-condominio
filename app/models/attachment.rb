class Attachment < ApplicationRecord
  belongs_to :ticket
  has_one_attached :file

  validates :file, presence: true
end