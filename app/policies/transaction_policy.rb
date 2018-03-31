class TransactionPolicy < ApplicationPolicy
  def index?
    true if user.present?
  end

  def search?
    index?
  end

  def destroy?
    present_and_belongs_to_user?
  end
end
