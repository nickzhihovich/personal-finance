class CategoryTransactions::Creator
  def initialize(amount:, user_id:, category_id:)
    @amount = amount
    @user_id = user_id
    @category_id = category_id
  end

  def create
    return unless valid?
    ActiveRecord::Base.transaction do
      create_category_transaction
      create_transaction
      update_category_balance
    end
  end

  private

  def create_category_transaction
    @transaction = CategoryTransaction.create(category_id: @category_id)
  end

  def create_transaction
    @transaction.transactions.create(amount: @amount, user_id: @user_id,
                                     date: Date.current)
  end

  def update_category_balance
    category.update(amount: total_amount)
  end

  def total_amount
    category.amount + @amount
  end

  def category
    @_category ||= Category.find(@category_id)
  end

  def valid?
    user.free_balance >= @amount
  end

  def user
    @_user ||= User.find(@user_id)
  end
end
