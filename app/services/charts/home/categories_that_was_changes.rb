class Charts::Home::CategoriesThatWasChanges < Struct.new(:transactions)
  def call
    categories_with_changes
  end

  private

  def categories_with_changes
    result = []
    result << categories_from_category_transactions
    result << categories_from_between_categories
    result.flatten.uniq
  end

  def categories_from_category_transactions
    category_transactions.map do |transaction|
      transaction.transactinable.category
    end
  end

  def categories_from_between_categories
    transactions_between_categories.map do |transaction|
      transaction.transactinable.category_to || transaction.transactinable.category_from
    end
  end

  delegate :category_transactions, to: :transactions
  delegate :between_categories, to: :transactions, prefix: true
end
