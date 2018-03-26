require 'rails_helper'

RSpec.describe 'Users::DefaultCategoriesCreator', type: :feature do
  let(:user) { create(:user) }

  it 'create six default categories' do
    expect do
      Users::DefaultCategoriesCreator.new(user).call
    end.to change(user.categories, :count).by(6)
  end
end
