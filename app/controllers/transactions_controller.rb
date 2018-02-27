class TransactionsController < ApplicationController

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
end
