require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_presence_of :title }
  it { validate_numericality_of :amount }
  it { validate_numericality_of(:amount).is_less_than(1_000_000_00) }
  it {
    is_expected.to validate_numericality_of(:amount)
      .is_greater_than_or_equal_to(0)
  }

  it { is_expected.to validate_length_of(:title).is_at_most(15) }

  it { is_expected.to belong_to(:user) }

  describe '#to_label' do
    let(:category) { create(:category) }
    let(:expected) { "#{category.title} | #{category.amount}" }

    it 'equal .title | .amount' do
      expect(category.to_label).to eq(expected)
    end
  end
end
