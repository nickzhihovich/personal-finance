require 'rails_helper'

RSpec.describe BetweenCategoriesTransactionsController, type: :controller do
  let(:user) { create(:user) }

  before do
    login_user user
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    context 'when valid' do
      let(:amount) { BigDecimal.new(Faker::Number.decimal(3, 2)) }
      let(:amount_from) { BigDecimal.new(10_000) }
      let(:category_from) { create(:category, user: user, amount: amount_from) }
      let(:category_to) { create(:category, user: user) }

      let(:params) do
        {
          between_categories_transaction:
            {
              amount: amount,
              category_from_id: category_from.id,
              category_to_id: category_to.id
            }
        }
      end

      it 'creates transaction' do
        expect do
          post :create, params: params
        end.to change(BetweenCategoriesTransaction, :count).by(1)
      end

      it 'redirects after create' do
        post :create, params: params
        expect(response).to redirect_to activity_page_path
      end
    end

    context 'when not valid' do
      let(:amount) { BigDecimal.new(Faker::Number.decimal(3, 2)) }
      let(:amount_from) { BigDecimal.new(10) }
      let(:category_from) { create(:category, user: user, amount: amount_from) }
      let(:category_to) { create(:category, user: user) }

      let(:params) do
        {
          between_categories_transaction:
            {
              amount: amount,
              category_from_id: category_from.id,
              category_to_id: category_to.id
            }
        }
      end

      it 'not creates new transaction' do
        expect do
          post :create, params: params
        end.not_to change(Transaction, :count)
      end

      it 'render :new template' do
        post :create, params: params
        expect(response).to render_template :new
      end
    end
  end
end
