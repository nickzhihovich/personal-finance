class CategoryTransactionForm < TransactionForm
  property :user_id

  validate :amount_valid?

  def amount_valid?
    errors.add(:amount, I18n.t('insufficient_funds')) if free_balance < amount.to_f
  end

  def free_balance
    user = User.find(user_id)
    user.free_balance
  end
end
