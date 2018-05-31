require 'rails_helper'

describe Views::TransactionTypeGenerator do
  let(:user) { create(:user) }
  let(:balance_transaction) { create(:balance_transactions) }
  let(:category) { create(:category, user: user, categorizable: user) }
  let(:category_transactinable) { create(:category_transaction, category: category) }
  let(:category_transaction) { create(:category_transactions, transactinable: category_transactinable) }

  let(:amount_from) { BigDecimal(1_000) }
  let(:category_from) { create(:category, user: user, amount: amount_from, categorizable: user) }
  let(:category_to) { create(:category, user: user, categorizable: user) }
  let(:between_categories_transaction) do
    BetweenCategoriesTransactions::Creator.new(
      amount: 5844,
      user_id: user.id,
      category_from_id: category_from.id,
      category_to_id: category_to.id
    ).create
  end

  before do
    visit '/activity_page'
  end

  it { page.has_content?(balance_transaction.transactinable.comment) }
  it { page.has_link?(category_transaction.transactinable.category.title) }
  it { page.has_link?(category_from.title) }
  it { page.has_link?(category_to.title) }
end
