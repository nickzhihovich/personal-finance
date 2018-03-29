class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: %i[update destroy edit]

  def index
    @categories = current_user.categories
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    respond_to do |format|
      if @category.save
        flash[:notice] = t('category_created')
      else
        flash[:alert] = t('category_not_created')
      end
      format.html { redirect_to categories_path }
      format.js
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        flash[:notice] = t('category_updated')
      else
        flash[:alert] = t('category_not_updated')
      end
      format.html { redirect_to categories_path }
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

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(
      :title,
      :amount
    )
  end
end
