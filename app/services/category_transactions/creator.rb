class CategoryTransactions::Creator
  Params = Struct.new(:amount, :user_id, :category_id)

  def initialize(params)
    @params = Params.new(params[:amount], params[:user_id], params[:category_id])
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
    @transaction = CategoryTransaction.create(category_id: @params[:category_id])
  end

  def create_transaction
    @transaction.transactions.create(amount: @params[:amount], user_id: @params[:user_id],
                                     date: Date.current)
  end

  def update_category_balance
    category.update(amount: total_amount)
  end

  def total_amount
    category.amount + @params[:amount]
  end

  def category
    Category.find(@params[:category_id])
  end

  def valid?
    user.free_balance >= @params[:amount]
  end

  def user
    User.find(@params[:user_id])
  end
end
