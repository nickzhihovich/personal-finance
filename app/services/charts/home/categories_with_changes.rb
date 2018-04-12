class Charts::Home::CategoriesWithChanges < Struct.new(:transactions)
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
    Charts::Home::CategoriesThatWasChanges.new(transactions).call
  end

  def incame_to_category(category)
    Charts::Home::CategoryAmountChange.new(
      category: category,
      transactions: transactions
    ).call
  end
end
