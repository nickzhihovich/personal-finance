class ExpenseTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_form
  before_action :set_categories

  def new
  end

  def create
    if @form.validate(permitted_params)
      ExpenseTransactions::Creator.new(create_params).create
      redirect_to activity_page_path, flash: {notice: t('transaction_create')}
    else
      render :new
    end
  end

  private

  def set_categories
    @categories = current_user.categories.decorate
  end

  def create_form
    @form ||= ExpenseTransactionForm.new(
      current_user.transactions.new,
      expense_transactions: ExpenseTransaction.new
    )
  end

  def create_params
    params_to_hash.merge(user_id: current_user.id)
  end

  def params_to_hash
    {
      amount: permitted_params[:amount].to_f,
      date: permitted_params[:date],
      category_id: permitted_params[:expense_transactions_attributes][:category_id]
    }
  end

  def permitted_params
    params.require(:transaction).permit(
      :amount,
      :date,
      expense_transactions_attributes: :category_id
    )
  end
end
