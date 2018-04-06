class Charts::Home::CategoriesDate < Struct.new(:categories)
  def data
    {
      categories_titles: categories_titles,
      categories_amounts: categories_amounts,
      charts_colors: charts_colors
    }
  end

  private

  def categories_titles
    categories.map(&:title)
  end

  def categories_amounts
    categories.map(&:amount)
  end

  def charts_colors
    Charts::ColorsArray.new(categories.count).collors_array
  end
end
