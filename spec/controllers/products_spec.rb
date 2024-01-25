# spec/controllers/products_controller_spec.rb

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @products' do
      product = FactoryBot.create(:product)
      get :index
      expect(assigns(:products)).to eq([product])
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new product to @product' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new product' do
        expect {
          post :create, params: { product: FactoryBot.attributes_for(:product) }
        }.to change(Product, :count).by(1)
      end

      it 'redirects to products_path' do
        post :create, params: { product: FactoryBot.attributes_for(:product) }
        expect(response).to redirect_to(products_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new product' do
        expect {
          post :create, params: { product: { name: nil, calories_count: nil } }
        }.not_to change(Product, :count)
      end

      it 'renders the new template' do
        post :create, params: { product: { name: nil, calories_count: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      product = FactoryBot.create(:product)
      get :edit, params: { id: product.id }
      expect(response).to be_successful
    end

    it 'assigns the requested product to @product' do
      product = FactoryBot.create(:product)
      get :edit, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'PUT #update' do
    let(:product) { FactoryBot.create(:product) }

    context 'with valid attributes' do
      it 'updates the requested product' do
        put :update, params: { id: product.id, product: { name: 'New Name' } }
        product.reload
        expect(product.name).to eq('New Name')
      end

      it 'redirects to products_path' do
        put :update, params: { id: product.id, product: { name: 'New Name' } }
        expect(response).to redirect_to(products_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the requested product' do
        put :update, params: { id: product.id, product: { name: nil } }
        product.reload
        expect(product.name).not_to eq(nil)
      end

      it 'renders the edit template' do
        put :update, params: { id: product.id, product: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:product) { FactoryBot.create(:product) }

    it 'destroys the requested product' do
      expect {
        delete :destroy, params: { id: product.id }
      }.to change(Product, :count).by(-1)
    end

    it 'redirects to products_path' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(products_path)
    end

    it 'sets a notice flash message' do
      delete :destroy, params: { id: product.id }
      expect(flash[:notice]).to be_present
    end

    context 'when product not found' do
      it 'redirects to products_path with an alert flash message' do
        delete :destroy, params: { id: 'invalid_id' }
        expect(response).to redirect_to(products_path)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
