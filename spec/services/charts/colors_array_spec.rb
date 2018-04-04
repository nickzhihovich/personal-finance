require 'rails_helper'

describe Charts::ColorsArray do
  let(:init_count) { Faker::Number.digit.to_i }
  let(:colors_array) { described_class.new(init_count).colors }

  it 'get array colors' do
    expect(colors_array.length).to eq(init_count)
  end
end
