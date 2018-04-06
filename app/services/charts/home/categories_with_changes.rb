class Charts::Home::CategoriesWithChanges < Struct.new(:category_transactions)
  def call
    categories_with_changes
  end

  private

  def categories_with_changes
    categories_that_was_changed.map do |item|
      {category: item, changes: incame_to_category(item)}
    end
  end

  def categories_that_was_changed
    category_transactions.map do |transaction|
      transaction.transactinable.category
    end.uniq
  end

  def incame_to_category(category)
    Charts::Home::CategoryAmountChange.new(
      category: category,
      category_transactions: category_transactions
    ).call
  end
end
