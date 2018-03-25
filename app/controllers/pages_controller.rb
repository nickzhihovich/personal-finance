class PagesController < ApplicationController
  def home
    @form = BalanceTransactionForm.new(BalanceTransaction.new, transactions: Transaction.new)
    return unless user_signed_in?
    @transactions = current_user.transactions.includes(:transactinable).limit(10).order('id desc')
    @categories = current_user.categories
  end
end
