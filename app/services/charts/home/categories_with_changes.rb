class Charts::Home::CategoriesWithChanges < Struct.new(:category_transactions)
  def call
    categories_with_changes
  end

  private

  def categories_with_changes
    @categories_with_changes = []
    categories_that_was_changed.each do |category|
      item = {category: category, changes: incame_to_category(category)}
      @categories_with_changes << item
    end
    @categories_with_changes
  end

  def categories_that_was_changed
    @categories = []
    category_transactions.each do |transaction|
      @categories << transaction.transactinable.category
    end
    @categories
  end

  def incame_to_category(category)
    Charts::Home::CategoryAmountChange.new(
      category: category,
      category_transactions: category_transactions
    ).call
  end
end
