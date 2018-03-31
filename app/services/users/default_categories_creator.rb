class Users::DefaultCategoriesCreator < Struct.new(:user)
  def call
    create_default_categories
  end

  private

  def create_default_categories
    default_categories_list.map do |title|
      user_categories.create(title: title, amount: 0)
    end
  end

  delegate :categories, to: :user, prefix: true

  def default_categories_list
    %w[Transportation Food House Entertainment Health Other]
  end

  delegate :categories, to: :user, prefix: true
end
