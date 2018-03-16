require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected validate_presence_of :amount }
  it { is_expected validate_presence_of :title }
  it { validate_numericality_of :amount }
  it {
    is_expected validate_numericality_of(:amount)
      .is_greater_than_or_equal_to(0)
  }

  it { is_expected validate_length_of(:title).is_at_most(15) }

  it { is_expected belong_to(:user) }
end
