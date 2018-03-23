class Category < ApplicationRecord
  belongs_to :user

  validates :amount, :title, presence: true
  validates :amount, presence: true, format: {with: /\A\d+(?:\.\d{0,2})?\z/},
                     numericality: {greater_than_or_equal_to: 0, less_than: 1_000_000_00}
  validates :title, length: {maximum: 15}
end
