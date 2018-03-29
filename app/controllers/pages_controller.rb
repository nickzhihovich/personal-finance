class PagesController < ApplicationController
  def home
    @form = BalanceTransactionForm.new(BalanceTransaction.new, transactions: Transaction.new)
    @transactions = current_user.transactions.limit(10).order('id desc') if user_signed_in?
  end
end
