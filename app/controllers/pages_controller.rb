class PagesController < ApplicationController
  def home
    return unless user_signed_in?
    @form = BalanceTransactionForm.new(Transaction.new, balance_transactions: BalanceTransaction.new)
    @last_transactions = current_user.transactions_last_ten
    @categories = current_user.categories.main_category
    @date = Charts::Home::CategoriesDate.new(current_user.categories_with_amount).data
  end
end
