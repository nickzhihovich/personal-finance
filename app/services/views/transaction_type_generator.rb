class Views::TransactionTypeGenerator < Struct.new(:transactinable)
  include ActionView::Helpers::TextHelper
  include ActionView::Context

  def type_block
    transaction_block
  end

  private

  def transaction_block
    case transactinable
    when BalanceTransaction
      balance_transacion_block
    when CategoryTransaction
      category_transaction_block
    when BetweenCategoriesTransaction
      between_categories_transaction_block
    end
  end

  def balance_transacion_block
    block(balance_content(I18n.t('transaction.types.to_balance')), balance_comment)
  end

  def category_transaction_block
    block(balance_content(I18n.t('transaction.types.from_balance_to')), ' ~> ', category_link(category))
  end

  def between_categories_transaction_block
    block(category_link(category_from), ' ~> ', category_link(category_to))
  end

  def block(*items)
    content_tag(:div) do
      items.length.times do |i|
        concat(items[i])
      end
    end
  end

  def balance_content(text)
    content_tag(:span, text, class: ['badge', 'badge-info'])
  end

  def balance_comment
    content_tag(:span, "( #{comment} )", class: 'transaction-comment')
  end

  def category_link(category)
    link_to(category.title, url_helpers.category_path(category), class: 'badge badge-success')
  end

  delegate :comment, :category, :category_from, :category_to, to: :transactinable
  delegate :link_to, to: 'ActionController::Base.helpers'
  delegate :url_helpers, to: 'Rails.application.routes'
end
