class BetweenCategoriesTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_new_form, only: %i[new create]
  before_action :set_categories, only: %i[new create] 

  def new
  end

  def create
    if @form.validate(permitted_params)
      between_categories_transaction_creator.create
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

  def set_categories
    @categories = current_user.categories.decorate
  end

  def create_new_form
    @form = BetweenCategoriesTransactionForm.new(
      current_user.transactions.new,
      between_categories_transactions: BetweenCategoriesTransaction.new
    )
  end

  def between_categories_transaction_creator
    BetweenCategoriesTransactions::Creator.new(create_params)
  end

  def create_params
    {
      user_id: current_user.id,
      category_from_id: permitted_params[:between_categories_transactions_attributes][:category_from_id],
      category_to_id: permitted_params[:between_categories_transactions_attributes][:category_to_id],
      amount: permitted_params[:amount].to_f
    }
  end

  def permitted_params
    params.require(:transaction).permit(
      :amount,
      between_categories_transactions_attributes: %i[category_from_id category_to_id]
    )
  end
end
