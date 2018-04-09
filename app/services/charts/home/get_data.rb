class Charts::Home::GetData < Struct.new(:transactions)
  def call
    categories_date
  end

  private

  def categories_date
    Charts::Home::CategoriesWithChangesDate.new(categories_with_changes).date
  end

  def categories_with_changes
    Charts::Home::CategoriesWithChanges.new(category_transactions).call
  end

  delegate :category_transactions, to: :transactions
end
