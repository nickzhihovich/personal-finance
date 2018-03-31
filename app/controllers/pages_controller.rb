class PagesController < ApplicationController
  def home
    return unless user_signed_in?
    @form = BalanceTransactionForm.new(Transaction.new, balance_transactions: BalanceTransaction.new)
    @transactions = current_user.transactions.includes(:transactinable).limit(10).order('id desc')
    @categories = current_user.categories.main_category
  end
end
