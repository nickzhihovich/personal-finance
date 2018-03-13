require 'rails_helper'

RSpec.describe 'Login with email', type: :feature do
  let(:user) { create(:user) }

  it 'visit log in' do
    visit '/users/sign_in'

    within('#new_user') do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
    end

    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end
end
