class BetweenCategoriesTransaction < ApplicationRecord
  has_many :transactions, as: :transactinable, dependent: :destroy
  belongs_to :category_from, class_name: 'Category'
  belongs_to :category_to, class_name: 'Category'

  validates :category_from_id, :category_to_id, presence: true
end
