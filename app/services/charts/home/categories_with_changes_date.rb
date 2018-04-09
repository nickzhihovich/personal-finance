class Charts::Home::CategoriesWithChangesDate < Struct.new(:categories_with_changes)
  def date
    chart_date
  end

  private

  def chart_date
    {
      categories_titles: categories_titles,
      categories_amounts: categories_amounts,
      charts_colors: charts_colors
    }
  end

  def categories_titles
    categories_with_changes.pluck(:category).pluck(:title)
  end

  def categories_amounts
    categories_with_changes.pluck(:changes).map(&:to_f)
  end

  def charts_colors
    Charts::ColorsArray.new(categories_with_changes.count).colors
  end
end
