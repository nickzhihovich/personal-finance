class ExpenseTransaction < ApplicationRecord
  belongs_to :category
  has_many :transactions, as: :transactinable, dependent: :destroy

  validates :comment, length: {maximum: 80}
  validates :category, presence: true
end
