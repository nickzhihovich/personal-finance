class BetweenCategoriesTransaction < ApplicationRecord
  has_many :transactions, as: :transactinable, dependent: :destroy

  validates :category_from_id, :category_to_id, presence: true
end
