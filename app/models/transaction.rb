class Transaction < ApplicationRecord
  belongs_to :user

  validates :amount, :date, presence: true
  validates :amount, numericality: true
end
