class Category < ApplicationRecord
  belongs_to :user

  validates :amount, :title, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 0}
  validates :title, length: {maximum: 15}
end
