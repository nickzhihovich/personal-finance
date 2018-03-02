class Transaction < ApplicationRecord
  belongs_to :user

  validates :sum, :date, presence: true
  validates :sum, numericality: true
end
