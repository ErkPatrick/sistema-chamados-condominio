class AttachmentPolicy < ApplicationPolicy
  def create?
    admin? || resident_owns_ticket?
  end

  def destroy?
    admin? || resident_owns_ticket?
  end

  private

  def resident_owns_ticket?
    user.resident? && user.units.include?(record.ticket.unit)
  end
end