require 'rails_helper'

RSpec.describe BetweenCategoriesTransaction, type: :model do
  it { is_expected.to validate_presence_of :category_from_id }
  it { is_expected.to validate_presence_of :category_to_id }

  it { is_expected.to have_many(:transactions) }
  it { is_expected.to belong_to(:category_from).class_name('Category') }
  it { is_expected.to belong_to(:category_to).class_name('Category') }
end
