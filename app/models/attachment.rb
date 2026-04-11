class Attachment < ApplicationRecord
  belongs_to :ticket

  validates :file, presence: true
end