module TransactionsHelper
  def type_item(transactinable)
    transaction_type(transactinable)
  end

  private

  def transaction_type(transactinable)
    case transactinable
    when BalanceTransaction
      content_tag(:span, t('activerecord.attributes.transaction.types.to_balance'),
        class: ['badge', 'badge-info'])
    when CategoryTransaction
      category_transaction_block(transactinable)
    when BetweenCategoriesTransaction
      between_categories_transaction_block(transactinable)
    end
  end

  def category_transaction_block(transactinable)
    content_tag(:div) do
      concat(content_tag(:span, t('activerecord.attributes.transaction.types.from_balance_to'),
        class: ['badge', 'badge-info']))
      concat(' ~> ')
      concat(link_to(transactinable.category.title, category_path(transactinable.category),
        class: 'badge badge-success'))
    end
  end

  def between_categories_transaction_block(transactinable)
    content_tag(:div) do
      concat(link_to(transactinable.category_from.title, category_path(transactinable.category_from),
        class: 'badge badge-success'))
      concat(' ~> ')
      concat(link_to(transactinable.category_to.title, category_path(transactinable.category_to),
        class: 'badge badge-success'))
    end
  end
end
