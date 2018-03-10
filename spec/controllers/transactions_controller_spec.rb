require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  login_user

  describe 'GET index' do
    let(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
    end

    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'activity page has a 200 status code' do
      visit activity_page_path
      expect(response.status).to eq(200)
    end
  end

  describe 'GET search' do
    it 'has a 200 status code' do
      get :search
      expect(response.status).to eq(200)
    end
  end
end
