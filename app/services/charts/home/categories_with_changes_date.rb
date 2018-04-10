class Charts::Home::CategoriesWithChangesDate < Struct.new(:categories_with_changes)
  def data
    {
      categories_titles: categories_titles,
      categories_amounts: categories_amounts,
      charts_colors: charts_colors
    }
  end

  private

  def categories_titles
    categories_with_changes.map { |item| item[:category].title }
  end

  def categories_amounts
    categories_with_changes.map { |item| item[:changes].to_f }
  end

  def charts_colors
    Charts::ColorsArray.new(categories_with_changes.count).collors_array
  end
end
