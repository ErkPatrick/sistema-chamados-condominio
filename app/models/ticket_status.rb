class TicketStatus < ApplicationRecord
  has_many :tickets, dependent: :restrict_with_error  # impede que um status seja deletado se houver chamados associados a ele. Isso é importante para não perder o histórico de chamados.

  validates :name, presence: true, uniqueness: true

  # Validações para garantir que apenas um status seja marcado como padrão e apenas um como final
  validate :only_one_default
  validate :only_one_final

  private

  def only_one_default
    if is_default? && TicketStatus.where(is_default: true).where.not(id: id).exists?  # where.not(id: id) exclui o próprio registro da verificação para salvar edições sem falso conflito.
      errors.add(:is_default, "já existe um status padrão definido")
    end
  end

  def only_one_final
    if is_final? && TicketStatus.where(is_final: true).where.not(id: id).exists?
      errors.add(:is_final, "já existe um status final definido")
    end
  end
end