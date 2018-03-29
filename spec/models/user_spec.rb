require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to have_many(:transactions).dependent(:destroy) }
  it { is_expected.to have_many(:authorizations).dependent(:destroy) }
  it { is_expected.to have_many(:categories).dependent(:destroy) }

  describe 'creation' do
    let(:user) { create(:user) }

    it 'can be created' do
      expect(user).to be_valid
    end

    it 'can not be created' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end
  end

  describe '#balance' do
    let(:user) { create(:user) }
    let!(:transaction1) { create(:transaction, :balance_transactions, user: user) }
    let!(:transaction2) { create(:transaction, :balance_transactions, user: user) }
    let(:expected_balance) { transaction1.amount + transaction2.amount }

    it 'calculates sum of transitions' do
      expect(user.balance).to eq(expected_balance)
    end
  end
end
