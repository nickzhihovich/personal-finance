class CategoryTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: :new

  def new
  end

  def create
    if category_transaction_creator.create
      redirect_to categories_path, flash: {notice: t('transaction_create')}
    else
      render :new
    end

    respond_to do |format|
      format.html
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
