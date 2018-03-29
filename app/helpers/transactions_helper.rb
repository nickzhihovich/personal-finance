module TransactionsHelper
  def type_item(transactinable)
    transaction_type(transactinable)
  end

  private

  def transaction_type(transactinable)
    case transactinable
    when BalanceTransaction
      content_tag(:span, t('activerecord.attributes.transaction.types.to_balance'))
    when CategoryTransaction
      category_transaction_block(transactinable)
    end
  end

  def category_transaction_block(transactinable)
    content_tag(:div) do
      concat(content_tag(:strong, t('activerecord.attributes.transaction.types.from_balance_to')))
      concat(' ~> ')
      concat(content_tag(:span, transactinable.category.title))
    end
  end
end
