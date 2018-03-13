require 'rails_helper'
require_relative '../support/oauth_spec_support'

RSpec.describe 'Signup with github', type: :feature do
  oauth_spec_support = OauthSpecSupport.new('github')
  before { oauth_spec_support.stub_omniauth }

  it 'visitor sign up' do
    expect do
      visit '/users/sign_in'

      click_link('Sign in with Github')
    end.to change(User, :count).by(1)
  end
end
