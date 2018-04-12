class ExpenseTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_form, only: %i[new create]
  before_action :set_categories
  before_action :edit_form, only: %i[edit update]

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

  def edit
  end

  def update
    if @form.validate(permitted_params)
      ExpenseTransactions::Updater.new(update_params.merge(init_amount: @form.model.amount)).update
      redirect_to activity_page_path, flash: {notice: t('transaction_update')}
    else
      render :edit
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

  def create_form
    @form ||= ExpenseTransactionForm.new(
      current_user.transactions.new,
      expense_transactions: ExpenseTransaction.new
    )
  end

  def edit_form
    @form ||= ExpenseTransactionForm.new(transaction, expense_transactions: expense_transaction)
  end

  def expense_transaction
    @expense_transaction ||= transaction.transactinable
  end

  def transaction
    @_transaction ||= Transaction.find(params[:id])
  end

  def update_params
    params_to_hash.merge(transaction_id: params[:id])
  end

  def create_params
    params_to_hash.merge(user_id: current_user.id)
  end

  def params_to_hash
    {
      amount: permitted_params[:amount].to_f,
      date: permitted_params[:date],
      category_id: expense_attributes[:category_id],
      comment: expense_attributes[:comment]
    }
  end

  def expense_attributes
    permitted_params[:expense_transactions_attributes]
  end

  def permitted_params
    params.require(:transaction).permit(
      :amount,
      :date,
      expense_transactions_attributes: %i[category_id comment]
    )
  end
end
