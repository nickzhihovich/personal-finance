require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_presence_of :date }
  it { validate_numericality_of :amount }
  it { validate_numericality_of(:amount).is_less_than(1_000_000_00) }
  it {
    is_expected.to validate_numericality_of(:amount)
      .is_greater_than_or_equal_to(0)
  }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_length_of(:comment).is_at_most(80) }

  it { is_expected.to belong_to(:user) }
end
