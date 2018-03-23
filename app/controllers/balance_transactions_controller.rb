class BalanceTransactionsController < ApplicationController
  before_action :find_balance_transaction, only: %i[edit update]

  def new
  end

  def create
    @balance_transaction = BalanceTransactions::Creator.new(balance_transaction_params)
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
  end

  def update
    if @transaction.update(transaction_params)
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

  def balance_transaction_params
    params.require(:balance_transaction).permit(
      :amount,
      :date,
      :comment,
      :user_id
    )
  end

  def find_balance_transaction
    @balance_transaction = Transaction.find(params[:id])
  end
end
