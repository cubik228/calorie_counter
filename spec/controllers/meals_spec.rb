  require 'rails_helper'

  RSpec.describe MealsController, type: :controller do
    let(:user) { create(:user) }
    let(:meal) { create(:meal, user: user) }
    let(:valid_attributes) { { name: 'Test Meal', total_calories: 500, date: Date.today } }
    let(:invalid_attributes) { { name: nil, date: nil } }

    before { sign_in user }

    describe 'GET #index' do
      it 'returns a success response' do
        get :index
        expect(response).to be_successful
      end
    end

    describe 'GET #show' do
      it 'returns a success response' do
        get :show, params: { id: meal.to_param }
        expect(response).to be_successful
      end
    end

    describe 'GET #new' do
      it 'returns a success response' do
        get :new
        expect(response).to be_successful
      end
    end

    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new Meal' do
          expect {
            post :create, params: { meal: valid_attributes }
          }.to change(Meal, :count).by(1)
        end

        it 'redirects to the created meal' do
          post :create, params: { meal: valid_attributes }
          expect(response).to redirect_to(Meal.last)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Meal' do
          expect {
            post :create, params: { meal: invalid_attributes }
          }.to change(Meal, :count).by(0)
        end

        it 'renders the new template' do
          post :create, params: { meal: invalid_attributes }
          expect(response).to render_template('new')
        end
      end
    end

  

    describe 'PUT #update' do
      context 'with valid parameters' do
        let(:updated_attributes) { { name: 'Updated Meal', total_calories: 600, date: Date.today } }

        it 'updates the requested meal' do
          put :update, params: { id: meal.to_param, meal: updated_attributes }
          meal.reload
          expect(meal.name).to eq('Updated Meal')
          expect(meal.total_calories).to eq(600)
        end

        it 'redirects to the updated meal' do
          put :update, params: { id: meal.to_param, meal: updated_attributes }
          expect(response).to redirect_to(meal)
        end
      end

      context 'with invalid parameters' do
        it 'does not update the requested meal' do
          put :update, params: { id: meal.to_param, meal: invalid_attributes }
          meal.reload
          expect(meal.name).not_to be_nil # Ensure the meal attributes remain unchanged
          expect(meal.date).not_to be_nil
        end

        it 'renders the edit template' do
          put :update, params: { id: meal.to_param, meal: invalid_attributes }
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the requested meal' do
        meal # Ensure the meal is created before attempting to destroy it
        expect {
          delete :destroy, params: { id: meal.to_param }
        }.to change(Meal, :count).by(-1)
      end

      it 'redirects to the meals list' do
        delete :destroy, params: { id: meal.to_param }
        expect(response).to redirect_to(meals_url)
      end
    end

    # Add more tests for the 'add_product' and 'create_consumed_product' actions if needed
  end
