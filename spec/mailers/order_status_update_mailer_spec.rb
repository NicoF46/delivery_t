# spec/mailers/order_status_update_mailer_spec.rb
require 'rails_helper'

RSpec.describe OrderStatusUpdateMailer, type: :mailer do
  describe '#notify_order_status_update' do
    let(:order_changes) do
      {
        1 => { status: 'processing', external_tracking_id: '123' },
        2 => { status: 'delivered' }
      }
    end

    let(:mail) { OrderStatusUpdateMailer.notify_order_status_update(order_changes) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Order Status Update')
      expect(mail.to).to eq([ENV['MANAGER_EMAIL']])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Order Status Update')
      expect(mail.body.encoded).to match('Here is the list of updates on the deliveries:')
      expect(mail.body.encoded).to match('Thank you for choosing our service!')
    end
  end
end
