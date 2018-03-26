class BetweenCategoriesTransactions::Creator
  Params = Struct.new(:amount, :user_id, :category_from_id, :category_to_id)

  def initialize(params)
    @params = Params.new(params[:amount], params[:user_id],
      params[:category_from_id], params[:category_to_id])
  end

  def save
    return unless valid?
    create_between_category_transaction
    update_categories_balance
  end

  private

  def create_between_category_transaction
    transaction = BetweenCategoriesTransaction.create(category_from_id: @params[:category_from_id],
                                                      category_to_id: @params[:category_to_id])
    transaction.transactions.create(amount: @params[:amount], user_id: @params[:user_id])
  end

  def update_categories_balance
    category_from.update(amount: category_from_amount)
    category_to.update(amount: category_to_amount)
  end

  def user
    User.find(@params[:user_id])
  end

  def category_from
    user.categories.find(@params[:category_from_id])
  end

  def category_from_amount
    category_from.amount.to_i - @params[:amount].to_i
  end

  def category_to
    user.categories.find(@params[:category_to_id])
  end

  def category_to_amount
    category_to.amount.to_i + @params[:amount].to_i
  end

  def valid?
    category_from.amount.to_i - category_to.amount.to_i >= 0
  end
end
