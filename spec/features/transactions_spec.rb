require 'rails_helper'

describe 'transactions' do
  let(:user) { create(:user) }
  let(:transaction) do
    create(:transaction, user_id: user.id)
  end

  before do
    login_as(user, scope: :user)
  end
end
