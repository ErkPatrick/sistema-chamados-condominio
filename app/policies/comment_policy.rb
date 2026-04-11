class CommentPolicy < ApplicationPolicy
  def create?
    admin_or_collaborator? || resident_owns_ticket?
  end

  private

  def resident_owns_ticket?
    user.resident? && user.units.include?(record.ticket.unit)
  end
end