require 'rails_helper'

RSpec.describe 'Users::Creator', type: :feature do
  let(:email) { Faker::Internet.email }
  let!(:user) { Users::Creator.new(email).call }
  let(:user_categories) { user.categories }
  let(:default_categories) { %w[Transportation Food House Entertainment Health Other] }

  it 'user created' do
    expect(User.where(email: email)).to be_present
  end

  it 'user categories length after created' do
    expect(user_categories.length).to eq(6)
  end

  it 'categories have default titles' do
    expect(user_categories.where(title: default_categories).length).to eq(6)
  end
end
