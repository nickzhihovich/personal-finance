class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :search_transactions

  def home
    @form = BalanceTransactionForm.new(Transaction.new, balance_transactions: BalanceTransaction.new)
    @last_transactions = current_user.transactions_last_ten
    @categories = current_user.categories.main_category.decorate
    @date = Charts::Home::GetData.new(@transactions).call
  end

  def date_chart
  end

  private

  def search_transactions
    @search = current_user.transactions.includes(:transactinable).ransack(params[:q])
    @transactions = @search.result(distinct: true)
    @data = Charts::Home::GetData.new(@transactions).call
  end
end
