class BetweenCategoriesTransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @categories = current_user.categories.decorate
  end

  def create
    if between_categories_transaction_creator.create
      redirect_to activity_page_path, flash: {notice: t('transaction_create')}
    else
      render :new
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def between_categories_transaction_creator
    BetweenCategoriesTransactions::Creator.new(create_params)
  end

  def create_params
    {
      user_id: current_user.id,
      category_from_id: permitted_params[:category_from_id],
      category_to_id: permitted_params[:category_to_id],
      amount: permitted_params[:amount].to_f
    }
  end

  def permitted_params
    params.require(:between_categories_transaction).permit(
      :amount,
      :category_from_id,
      :category_to_id
    )
  end
end
