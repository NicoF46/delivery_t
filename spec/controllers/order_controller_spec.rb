# spec/controllers/orders_controller_spec.rb

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) } # Asume que tienes un modelo de usuario llamado User

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new order to @order' do
      get :new
      expect(assigns(:order)).to be_a_new(Order)
    end
  end

  describe 'POST #create' do
    let(:product) { create(:product) }
    let(:valid_params) do
      {
        order: {
          product_id: product.id,
          customer_name: 'John Doe',
          address: '123 Main St',
          zip_code: '12345',
          shipping_method: 'Express'
        }
      }
    end

    let(:invalid_params) do
      {
        order: {
          product_id: nil, # Invalid, as it's missing required fields
          customer_name: nil,
          address: nil,
          zip_code: nil,
          shipping_method: nil
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new order' do
        expect { post :create, params: valid_params }.to change { Order.count }.by(1)
      end
      it 'redirects to the new order page' do
        post :create, params: valid_params
        expect(response).to redirect_to(new_order_path)
      end

      it 'sets a success flash notice' do
        post :create, params: valid_params
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new order' do
        expect do
          post :create, params: invalid_params
        end.not_to change(Order, :count)
      end

      it 'renders the new template' do
        post :create, params: invalid_params
        expect(response).to redirect_to(new_order_path)
      end

      it 'sets an error flash alert' do
        post :create, params: invalid_params
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'GET #show' do
    let!(:order) { create(:order) }

    it 'renders the show template' do
      get :show, params: { id: order.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the requested order to @order' do
      get :show, params: { id: order.id }
      expect(assigns(:order)).to eq(order)
    end
  end
end
