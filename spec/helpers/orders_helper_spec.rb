require 'rails_helper'

RSpec.describe OrdersHelper, type: :helper do
  describe OrdersHelper::OrderUpdater do
    let(:order_updater) { OrdersHelper::OrderUpdater.new(order) }

    describe '#update_shipping_status' do
      context 'when order status is processing' do
        let(:order) { create(:order, status: 'processing') }

        before do
          allow(Fedex::Shipment).to receive(:create).and_return(double(status: 'awaiting_pickup', id: '123'))
        end

        it 'creates new shipment' do
          result = order_updater.update_shipping_status
          expect(result).to eq({ status: 'awaiting_pickup', external_tracking_id: '123' })
        end
      end

      context 'when order status is not processing' do
        let(:order) { create(:order, status: 'awaiting_pickup') }

        before do
          allow(Fedex::Shipment).to receive(:find).and_return(double(status: 'delivered'))
        end

        it 'updates shipping status with an existing shipment' do
          result = order_updater.update_shipping_status
          expect(result).to eq({ status: 'delivered' })
        end
      end
    end
  end
end
