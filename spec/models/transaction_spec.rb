require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'validations' do
    it { should validate_presence_of :amount }
    it { should validate_presence_of :date }
    it { validate_numericality_of :amount }
    it {
      should validate_numericality_of(:amount)
        .is_greater_than_or_equal_to(0)
    }

    it { should validate_presence_of :user }
    it { should validate_length_of(:comment).is_at_most(80) }
  end

  context 'associations' do
    it { should belong_to(:user) }
  end
end
