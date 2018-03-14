require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  before(:each) do
    login_user user
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'renders the :edit template' do
      get :edit, params: {id: category.id}
      expect(response).to render_template :edit
    end
  end

  describe 'GET #index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'Post #create' do
    context 'when valid' do
      it 'creates category' do
        expect do
          post :create, params: {category: attributes_for(:category)}
        end.to change(Category, :count).by(1)
      end

      it 'redirects after create' do
        post :create, params: {category: attributes_for(:category)}
        expect(response).to redirect_to categories_path
      end
    end

    context 'where not valid' do
      it 'not creates new category' do
        expect do
          post :create, params: {category: {title: nil}}
        end.to_not change(Category, :count)
      end

      it 'redirect to categories path' do
        post :create, params: {category: {title: nil}}
        expect(response).to redirect_to categories_path
      end
    end
  end

  describe 'PUT #update' do
    context 'when valid' do
      let(:amount) { Faker::Number.digit }
      let(:title) { Faker::Internet.user_name(5..15) }
      let(:params) do
        {
          id: category.id,
          category: attributes_for(:category,
            amount: amount,
            title: title)
        }
      end

      before { put :update, params: params }

      it 'updates category' do
        category.reload
        expect(category.amount).to eq(amount)
        expect(category.title).to eq(title)
      end

      it 'redirects after update' do
        put :update, params: {id: category.id, category: attributes_for(:category)}
        expect(response).to  redirect_to categories_path
      end
    end

    context 'when not valid' do
      let(:init_amount) { category.amount }
      let(:init_title) { category.title }
      let(:params) do
        {
          id: category.id,
          category: attributes_for(:category,
            amount: nil,
            title: nil)
        }
      end

      before { put :update, params: params }

      it 'not updates category' do
        category.reload
        expect(category.amount).to eq(init_amount)
        expect(category.title).to eq(init_title)
      end

      it 'redirect to categories path' do
        put :update, params: {
          id: category.id,
          category: attributes_for(:category,
            amount: nil,
            title: nil)
        }
        expect(response).to redirect_to categories_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:category) { create(:category, user: user) }

    it 'destroys category' do
      expect do
        delete :destroy, params: {id: category.id}
      end.to change(Category, :count).by(-1)
    end
  end
end
