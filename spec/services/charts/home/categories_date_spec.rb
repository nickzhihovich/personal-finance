require 'rails_helper'

describe Charts::Home::CategoriesDate do
  let(:init_count) { Faker::Number.number(2).to_i }
  let(:categories) { create_list(:main_category, init_count) }
  let(:categories_date) { described_class.new(categories).data }
  let(:categories_titles) { categories.pluck(:title) }
  let(:categories_amounts) { categories.pluck(:amount) }

  it { expect(categories.length).to eq(init_count) }
  it { expect(categories_date.length).to eq(3) }
  it { expect(categories_date[:categories_titles].length).to eq(init_count) }
  it { expect(categories_date[:categories_amounts].length).to eq(init_count) }
  it { expect(categories_date[:charts_colors].length).to eq(init_count) }
  it { expect(categories_date[:categories_titles]).to eq(categories_titles) }
  it { expect(categories_date[:categories_amounts]).to eq(categories_amounts) }
end
