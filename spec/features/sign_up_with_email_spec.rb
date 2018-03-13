require 'rails_helper'

RSpec.describe 'Sign up use email', type: :feature do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  it 'visit sign up' do
    expect do
      visit '/users/sign_up'

      within('#new_user') do
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password
      end

      click_button 'Sign up'
    end.to change(User, :count).by(1)
  end
end
