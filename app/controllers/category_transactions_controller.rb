class CategoryTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: :new

  def new
  end

  def create
    @category_transaction = CategoryTransactions::Creator.new(category_transaction_params)
    respond_to do |format|
      if @category_transaction.call
        flash[:notice] = t('transaction_create')
      else
        flash[:alert] = t('category_transaction_not_create')
      end
      format.html { redirect_to categories_path }
      format.js
    end
  end

  private

  def category_transaction_params
    params.require(:category_transaction).permit(
      :amount
    ).merge(user_id: current_user.id, category_id: params[:id])
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
