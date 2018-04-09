require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:user) { create(:user) }

  before do
    login_user user
  end

  describe 'GET home' do
    it 'has a 200 status code' do
      get :home
      expect(response.status).to eq(200)
    end
  end
end
