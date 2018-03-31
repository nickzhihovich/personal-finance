class Users::DefaultCategoriesCreator < Struct.new(:user)
  def create_default_categories
    default_categories_list.map do |title|
      Category.create(title: title, amount: 0, user_id: user.id, categorizable: user)
    end
  end

  private

  def default_categories_list
    %w[Transportation Food House Entertainment Health Other]
  end
end
