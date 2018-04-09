class PagesController < ApplicationController
  before_action :authenticate_user!, only: :date_chart
  before_action :search_transactions, only: %i[home date_chart]

  def home
    return unless user_signed_in?
    @form = BalanceTransactionForm.new(Transaction.new, balance_transactions: BalanceTransaction.new)
    @last_transactions = current_user.transactions_last_ten
    @categories = current_user.categories.main_category
    @date = Charts::Home::GetData.new(@transactions).call
  end

  def date_chart
  end

  private

  def search_transactions
    return unless user_signed_in?
    @search = current_user.transactions.includes(:transactinable).ransack(params[:q])
    @transactions = @search.result(distinct: true)
    @data = Charts::Home::GetData.new(@transactions).call
  end
end
