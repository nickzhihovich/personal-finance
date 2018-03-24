class CategoryTransactions::Creator
  Params = Struct.new(:amount, :user_id, :category_id)

  def initialize(params)
    @params = Params.new(params[:amount], params[:user_id], params[:category_id])
  end

  def call
    return unless valid?
    create_category_transaction
    update_category_balance
  end

  private

  def create_category_transaction
    ActiveRecord::Base.transaction do
      transaction = CategoryTransaction.create(category_id: @params[:category_id])
      transaction.transactions.create(amount: @params[:amount], user_id: @params[:user_id])
    end
  end

  def update_category_balance
    category.update(amount: total_amount)
  end

  def total_amount
    category.amount.to_i + @params[:amount].to_i
  end

  def category
    Category.find(@params[:category_id])
  end

  def valid?
    user.free_balance - @params[:amount].to_i >= 0
  end

  def user
    User.find(@params[:user_id])
  end
end
