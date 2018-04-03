class Charts::Home::CategoriesDate < Struct.new(:categories)
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
    categories.pluck(:title)
  end

  def categories_amounts
    categories.pluck(:amount).map(&:to_f)
  end

  def charts_colors
    Charts::ColorsArray.new(categories.count).colors
  end
end
