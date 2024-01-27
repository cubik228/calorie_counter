# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MealsController, type: :controller do
  let(:user) { create(:user) }
  let(:meal) { create(:meal, user: user) }

  before { sign_in user }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all meals to @meals' do
      get :index
      expect(assigns(:meals)).to eq([meal])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: meal.to_param }
      expect(response).to be_successful
    end

    it 'assigns the requested meal to @meal' do
      get :show, params: { id: meal.to_param }
      expect(assigns(:meal)).to eq(meal)
    end

    it 'assigns consumed products and total calories' do
      consumed_product = create(:consumed_product, meal: meal)
      get :show, params: { id: meal.to_param }
      expect(assigns(:consumed_products)).to eq([consumed_product])
      expect(assigns(:total_calories)).to eq(consumed_product.quantity)
    end
  end

  describe 'GET #generate_pdf' do
    it 'returns a PDF response' do
      get :generate_pdf, params: { id: meal.to_param, format: :pdf }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq 'application/pdf'
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new meal to @meal' do
      get :new
      expect(assigns(:meal)).to be_a_new(Meal)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Meal' do
        expect do
          post :create, params: { meal: attributes_for(:meal) }
        end.to change(Meal, :count).by(1)
      end

      it 'redirects to the created meal' do
        post :create, params: { meal: attributes_for(:meal) }
        expect(response).to redirect_to(Meal.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Meal' do
        expect do
          post :create, params: { meal: attributes_for(:meal, name: nil) }
        end.not_to change(Meal, :count)
      end

      it 'renders the new template' do
        post :create, params: { meal: attributes_for(:meal, name: nil) }
        expect(response).to render_template('new')
      end
    end
  end

  # Add similar tests for edit, update, destroy, add_product, create_consumed_product actions
end
