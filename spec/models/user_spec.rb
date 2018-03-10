require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    before do
      @user = create(:user)
    end
    it 'can be created' do
      expect(@user).to be_valid
    end

    it 'can not be created' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end
  end

  describe 'balance' do
    it 'calculate' do
      user = create(:user)
      transaction1 = create(:transaction, user_id: user.id)
      transaction2 = create(:transaction, user_id: user.id)
      expect(user.balance).to eq(transaction1.amount.to_i + transaction2.amount.to_i)
    end
  end
end
