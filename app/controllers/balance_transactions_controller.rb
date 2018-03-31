class BalanceTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_new_form, only: %i[new create]
  before_action :create_edit_form, only: %i[edit update]

  def new
  end

  def create
    if @form.validate(permitted_params)
      BalanceTransactions::Creator.new(create_params).create
      redirect_to activity_page_path, flash: {notice: t('transaction_create')}
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @form.validate(permitted_params)
      BalanceTransactions::Updater.new(update_params).update
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

  def create_new_form
    @form = BalanceTransactionForm.new(Transaction.new, balance_transactions: BalanceTransaction.new)
  end

  def create_edit_form
    @form = BalanceTransactionForm.new(transaction, balance_transactions: balance_transaction)
  end

  def create_params
    params_to_hash.merge(user_id: current_user.id)
  end

  def update_params
    params_to_hash.merge(transaction_id: params[:id])
  end

  def balance_transaction
    @balance_transaction ||= transaction.transactinable
  end

  def transaction
    @_transaction ||= Transaction.find(params[:id])
  end

  def params_to_hash
    {
      date: permitted_params[:date],
      comment: permitted_params[:balance_transactions_attributes][:comment],
      amount: permitted_params[:amount]
    }
  end

  def permitted_params
    params.require(:transaction).permit(
      :amount,
      :date,
      balance_transactions_attributes: :comment
    )
  end
end
