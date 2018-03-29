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
      update_categories_balance
    end
  end

  private

  def create_between_category_transaction
    transaction = BetweenCategoriesTransaction.create(category_from_id: @category_from_id,
                                                      category_to_id: @category_to_id)
    transaction.transactions.create(amount: @amount, user_id: @user_id,
                                    date: Date.current)
  end

  def update_categories_balance
    category_from.update(amount: category_from_amount)
    category_to.update(amount: category_to_amount)
  end

  def valid?
    category_from.amount >= @amount
  end

  def category_from_amount
    category_from.amount - @amount
  end

  def category_from
    user.categories.find(@category_from_id)
  end

  def category_to_amount
    category_to.amount + @amount
  end

  def category_to
    user.categories.find(@category_to_id)
  end

  def user
    User.find(@user_id)
  end
end
