class BetweenCategoriesTransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @categories = current_user.categories
  end

  def create
    if between_categories_transaction_creator.create
      flash[:notice] = t('transaction_create')
    else
      flash[:alert] = t('category_transaction_not_create')
    end

    respond_to do |format|
      format.html { redirect_to categories_path }
      format.js
    end
  end

  private

  def between_categories_transaction_creator
    BetweenCategoriesTransactions::Creator.new(permitted_params)
  end

  def permitted_params
    params.require(:between_categories_transaction).permit(
      :amount,
      :category_from_id,
      :category_to_id
    ).merge(user_id: current_user.id)
  end
end
