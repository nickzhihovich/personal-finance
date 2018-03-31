class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: %i[show update destroy edit]
  before_action :set_parent, only: %i[new create]

  def index
    @categories = current_user.categories.main_category
  end

  def show
    @subcategories = @category.categories
  end

  def new
    @category = @parent.categories.new
  end

  def create
    @category = Categories::Creator.new(category_params).call
    respond_to do |format|
      if @category.save
        flash[:notice] = t('category_created')
      else
        flash[:alert] = t('category_not_created')
      end
      format.html { redirect_to @category }
      format.js
    end
  end

  def edit
  end

  def update
    if @category.update(permitted_params)
      redirect_to categories_path, flash: {notice: t('category_updated')}
    else
      render :edit
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      flash[:notice] = t('deleted_category_seccess')
      format.html { redirect_to categories_path }
      format.js
    end
  end

  private

  def category_creator
    Categories::Creator.new(parent: @parent, params: permitted_params)
  end

  def set_parent
    @parent ||= category || current_user
  end

  def category
    category_id = params[:category_id]
    current_user.categories.find_by(id: category_id) if category_id.present?
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def permitted_params
    params.require(:category).permit(
      :title,
      :categorizable_type,
      :categorizable_id
    )
  end
end
