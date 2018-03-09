class TransactionsController < ApplicationController
  before_action :find_transaction, only: %i[update destroy edit]
  before_action :search_for_transactions, only: %i[index search]

  def index
  end

  def search
    render :index
  end

  def new
    @transaction = current_user.transactions.new
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    respond_to do |format|
      if @transaction.save
        flash[:notice] = t('transaction_create')
      else
        flash[:alert] = t('transaction_not_create')
      end
      format.html { redirect_to activity_page_path }
      format.js
    end
  end

  def edit
  end

  def update
    @transaction.update(transaction_params)
    respond_to do |format|
      if @transaction.update(transaction_params)
        flash[:notice] = t('transaction_update')
      else
        flash[:alert] = t('transaction_not_update')
      end
      format.html { redirect_to activity_page_path }
      format.js
    end
  end

  def destroy
    @transaction.destroy

    respond_to do |format|
      flash[:notice] = t('transaction_update')
      format.html { redirect_to activity_page_path }
      format.js
    end
  end

  private

  def search_for_transactions
    @search = current_user.transactions.ransack(params[:q])
    @transactions = @search.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

  def find_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(
      :amount,
      :date,
      :comment
    )
  end
end
