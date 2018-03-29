class CategoryTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: :new

  def new
  end

  def create
    if category_transaction_creator.create
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

  def category_transaction_creator
    CategoryTransactions::Creator.new(create_params)
  end

  def create_params
    {
      user_id: current_user.id,
      category_id: params[:id],
      amount: permitted_params[:amount].to_f
    }
  end

  def permitted_params
    params.require(:category_transaction).permit(
      :amount
    )
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
