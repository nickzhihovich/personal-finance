require 'rails_helper'
require_relative '../support/oauth_spec_support'

RSpec.describe 'Signup with google', type: :feature do
  oauth_spec_support = OauthSpecSupport.new('google')
  before { oauth_spec_support.stub_omniauth }

  it 'visit sign up' do
    expect do
      visit '/users/sign_in'

      click_link('Sign in with Google')
    end.to change(User, :count).by(1)
  end
end
