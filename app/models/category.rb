class Category < ApplicationRecord
  belongs_to :user
  has_many :category_transactions, dependent: :destroy
  has_many :category_trans_from, class_name: 'BetweenCategoriesTransaction', foreign_key: 'category_from'
  has_many :category_trans_to, class_name: 'BetweenCategoriesTransaction', foreign_key: 'category_to'

  validates :amount, :title, presence: true
  validates :amount, presence: true, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
                     numericality: {greater_than_or_equal_to: 0, less_than: 1_000_000_00}
  validates :title, length: {maximum: 15}

  def to_label
    "#{title} | #{amount}"
  end
end
