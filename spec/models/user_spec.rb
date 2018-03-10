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

  describe '#balance' do
    before do
      @user = create(:user)
      @transaction1 = create(:transaction, user: @user)
      @transaction2 = create(:transaction, user: @user)
    end

    it 'calculates sum of transitions' do
      expect(@user.balance).to eq(@transaction1.amount.to_i + @transaction2.amount.to_i)
    end
  end
end
