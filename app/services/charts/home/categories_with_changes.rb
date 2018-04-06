class Charts::Home::CategoriesWithChanges < Struct.new(:category_transactions)
  def call
    categories_with_changes
  end

  private

  def categories_with_changes
    categories_that_was_changed.reduce([]) do |categories, item|
      categories << {category: item, changes: incame_to_category(item)}
    end
  end

  def categories_that_was_changed
    category_transactions.reduce([]) do |categories, transaction|
      categories << transaction.transactinable.category
    end.uniq
  end

  def incame_to_category(category)
    Charts::Home::CategoryAmountChange.new(
      category: category,
      category_transactions: category_transactions
    ).call
  end
end
