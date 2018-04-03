class PagesController < ApplicationController
  def home
    return unless user_signed_in?
    @form = BalanceTransactionForm.new(Transaction.new, balance_transactions: BalanceTransaction.new)
    @transactions = current_user.transactions.includes(:transactinable).limit(10).order('id desc')
    @categories = current_user.categories.main_category
    @date = Charts::Home::CategoriesDate.new(current_user.categories_have_budget).date
  end
end
