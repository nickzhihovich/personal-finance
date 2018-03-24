class BalanceTransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_new_form, only: %i[new create]
  before_action :find_balance_transaction, only: %i[edit update]

  def new
  end

  def create
    @balance_transaction = BalanceTransactions::Creator.new(@form)
    if @balance_transaction.create
      flash[:notice] = t('transaction_create')
    else
      flash[:alert] = t('transaction_not_create')
    end
    respond_to do |format|
      format.html { redirect_to activity_page_path }
      format.js
    end
  end

  def edit
    @balance_transaction = BalanceTransactionsForm.new(params[:id])
  end

  def update
    if BalanceTransactions::Updater.new(update_params).update
      flash[:notice] = t('transaction_update')
    else
      flash[:alert] = t('transaction_not_update')
    end

    respond_to do |format|
      format.html { redirect_to activity_page_path }
      format.js
    end
  end

  private

  def create_new_form
    @form = BalanceTransactions::Form.new(balance_transaction: BalanceTransaction.new, transactinable: Transaction.new)
  end

  def create_params
    permitted_params.merge(user_id: current_user.id)
  end

  def update_params
    permitted_params.merge(transaction_id: @transaction.id)
  end

  def permitted_params
    params.require(:balance_transaction).permit(
      :amount,
      :date,
      :comment
    )
  end

  def find_balance_transaction
    @transaction = Transaction.find(params[:id])
  end
end
