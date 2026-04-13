class UnitPolicy < ApplicationPolicy
  
  def show?
    admin_or_collaborator?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin? || user.collaborator?
        scope.all
      else
        scope.none
      end
    end
  end
end