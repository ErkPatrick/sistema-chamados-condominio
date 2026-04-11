class Block < ApplicationRecord
    has_many :units, dependent: :destroy

    validates :identifier, presence:true, uniqueness: true
    validates :floors, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :units_per_floor, presence: true, numericality: { only_integer: true, greater_than: 0 }

    after_create :generate_units

    private

    def generate_units
        (1..floors).each do |floor|
            (1..units_per_floor).each do |number|
                units.create!(
                    floor: floor,
                    number: number,
                    identifier: "#{identifier}-#{floor}#{number.to_s.rjust(2, '0')}"  # garante que a string tenha pelo menos 2 caracteres, preenchendo com '0' à esquerda se necessário
                )
            end
        end
    end
end
