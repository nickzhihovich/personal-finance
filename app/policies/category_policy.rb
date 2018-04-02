class CategoryPolicy < ApplicationPolicy
  def show?
    present_and_belongs_to_user?
  end

  def update?
    present_and_belongs_to_user?
  end

  def destroy?
    present_and_belongs_to_user?
  end
end
