class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_transaction, only: :destroy
  before_action :search_for_transactions, only: %i[index search]

  def index
    @categories = current_user.categories
  end

  def search
    render :index
  end

  def destroy
    if Transactions::Destroyer.new(@transaction).call
      flash[:notice] = t('delete_transaction_seccess')
    else
      flash[:alert] = t('can_not_be_removed')
    end

    respond_to do |format|
      format.html { redirect_to activity_page_path }
      format.js
    end
  end

  private

  def search_for_transactions
    @search = current_user.transactions.includes(:transactinable).ransack(params[:q])
    @transactions = @search.result(distinct: true)
                           .paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def find_transaction
    @transaction = Transaction.find(params[:id])
    authorize @transaction
  end

  def transaction_params
    params.require(:transaction).permit(
      :amount,
      :date
    )
  end
end
