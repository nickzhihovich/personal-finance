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
end
