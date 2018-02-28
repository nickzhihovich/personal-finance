class TransactionsController < ApplicationController
  before_action :find_transaction, only: %i[update destroy edit]
  def new
    @transaction = current_user.transactions.new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    if @transaction.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @transaction.update(transaction_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def find_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(
      :sum,
      :date,
      :comment
    )
  end
end
