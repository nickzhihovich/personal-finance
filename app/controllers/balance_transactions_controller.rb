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
    @form = BalanceTransactionForm.new(BalanceTransaction.new, transactions: Transaction.new)
  end

  def create_edit_form
    @form = BalanceTransactionForm.new(balance_transaction, transactions: transaction)
  end

  def create_params
    params_to_hash.merge(user_id: current_user.id)
  end

  def update_params
    params_to_hash.merge(transaction_id: permitted_params[:transactions_attributes][:id])
  end

  def transaction
    @_transaction ||= Transaction.find(params[:id])
  end

  def balance_transaction
    @_balance_transaction ||= transaction.transactinable
  end

  def params_to_hash
    {
      date: permitted_params[:transactions_attributes][:date],
      comment: permitted_params[:comment],
      amount: permitted_params[:transactions_attributes][:amount]
    }
  end

  def permitted_params
    params.require(:balance_transaction).permit(
      :comment,
      transactions_attributes: %i[id amount date]
    )
  end
end
