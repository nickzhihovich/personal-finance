require 'rails_helper'

RSpec.describe ExpenseTransaction, type: :model do
  it { is_expected.to validate_presence_of :category }

  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:transactions).dependent(:destroy) }
end
