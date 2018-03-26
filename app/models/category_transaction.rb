class CategoryTransaction < ApplicationRecord
  belongs_to :category
  has_many :transactions, as: :transactinable, dependent: :destroy

  validates :category, presence: true
end
