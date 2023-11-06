require 'rails_helper'

RSpec.describe BulkHelper, type: :helper do
  describe BulkHelper::OrderUpdater do
    let(:updates) do
      {
        1 => { status: 'awaiting_pickup', external_tracking_id: '123' },
        2 => { status: 'in_transit', external_tracking_id: '456' },
        3 => { status: 'delivered' }
      }
    end
    let(:order_updater) { BulkHelper::OrderUpdater.new(updates) }

    describe '#perform' do
      context 'when updates are present' do
        it 'performs bulk update on orders' do
          allow(ActiveRecord::Base.connection).to receive(:execute)
          order_updater.perform
          expect(ActiveRecord::Base.connection).to have_received(:execute).with(/UPDATE orders SET/)
        end
      end

      context 'when updates are empty' do
        it 'does not perform bulk update' do
          allow(ActiveRecord::Base.connection).to receive(:execute)
          empty_order_updater = BulkHelper::OrderUpdater.new({})
          empty_order_updater.perform
          expect(ActiveRecord::Base.connection).not_to have_received(:execute)
        end
      end
    end
  end
end
