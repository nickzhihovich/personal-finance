class BetweenCategoriesTransactions::Creator
  def initialize(amount:, user_id:, category_from_id:, category_to_id:)
    @amount = amount
    @user_id = user_id
    @category_from_id = category_from_id
    @category_to_id = category_to_id
  end

  def create
    return unless valid?
    ActiveRecord::Base.transaction do
      create_between_category_transaction
      create_transaction
      transfer_money_between_categories
    end
  end

  private

  def create_between_category_transaction
    @transaction = BetweenCategoriesTransaction.create(
      category_from_id: @category_from_id,
      category_to_id: @category_to_id
    )
  end

  def create_transaction
    @transaction.transactions.create(
      amount: @amount,
      user_id: @user_id,
      date: Date.current
    )
  end

  def transfer_money_between_categories
    Categories::BalanceTransferer.new(
      category_from: category_from,
      category_to: category_to,
      amount: @amount
    ).transfer
  end

  def valid?
    category_from.amount >= @amount && @amount > 0
  end

  def category_from
    @category_from ||= user_categories.find(@category_from_id)
  end

  def category_to
    @category_to ||= user_categories.find(@category_to_id)
  end

  def user
    @user ||= User.find(@user_id)
  end

  delegate :categories, to: :user, prefix: true
end
