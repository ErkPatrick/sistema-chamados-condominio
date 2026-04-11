class UnitUser < ApplicationRecord
  belongs_to :unit
  belongs_to :user

  validates :unit_id, uniqueness: { scope: :user_id }  # validação para complementar o índice composto criado na migration
end