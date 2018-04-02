require 'rails_helper'

RSpec.describe CategoryDecorator do
  let(:category) { create(:main_category).decorate }
  let(:expected) { "#{category.title} | #{category.amount}" }

  it 'equal .title | .amount' do
    expect(category.to_label).to eq(expected)
  end
end
