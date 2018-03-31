class TransactionPolicy < ApplicationPolicy
  def edit?
    present_and_belongs_to_user?
  end

  def update?
    present_and_belongs_to_user?
  end

  def destroy?
    present_and_belongs_to_user?
  end

  private

  def present_and_belongs_to_user?
    return true if user.present? && user == record.user
  end
end
