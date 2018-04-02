class Categories::Creator
  def initialize(parent:, params:)
    @parent = parent
    @title = params[:title]
    @user_id = params[:user_id]
  end

  def create
    create_category
  end

  private

  def create_category
    @parent.sub_categories.create(title: @title, user_id: @user_id, amount: 0)
  end
end
