require 'rails_helper'

RSpec.describe BalanceTransaction, type: :model do
  it { is_expected.to validate_length_of(:comment).is_at_most(80) }
end
