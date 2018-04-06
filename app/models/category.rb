class Category < ApplicationRecord
  has_many :category_transactions, dependent: :destroy
  belongs_to :user
  has_many :categories_from, class_name: 'BetweenCategoriesTransaction', foreign_key: 'category_from'
  has_many :categories_to, class_name: 'BetweenCategoriesTransaction', foreign_key: 'category_to'
  belongs_to :categorizable, polymorphic: true
  has_many :sub_categories, as: :categorizable, dependent: :destroy, class_name: 'Category'

  scope :main_category, -> { where(categorizable_type: 'User') }
  scope :with_amount, -> { where.not(amount: 0) }

  validates :amount, :title, presence: true
  validates :amount, presence: true, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
                     numericality: {greater_than_or_equal_to: 0, less_than: 1_000_000_00}
  validates :title, length: {maximum: 15}
end
