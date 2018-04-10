class Charts::Home::GetData < Struct.new(:transactions)
  def call
    categories_date
  end

  private

  def categories_date
    Charts::Home::CategoriesWithChangesDate.new(categories_with_changes).data
  end

  def categories_with_changes
    Charts::Home::CategoriesWithChanges.new(transactions).call
  end
end
