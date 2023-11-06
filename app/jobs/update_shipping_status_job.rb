class UpdateShippingStatusJob < ActiveJob::Base
  queue_as :default

  def perform
    orders_to_update = Order.where.not(status: :delivered)
    orders_to_update.find_each(batch_size: 100) do |order|
      update_shipping_status(order)
    end
  end

  private

  def update_shipping_status(order)
    if order.status == 'processing'
      shipment = Fedex::Shipment.create
      order.update!(status: shipment.status, external_tracking_id: shipment.id.to_s)
    else
      shipment = Fedex::Shipment.find(order&.external_tracking_id&.to_i)
      new_status = shipment.status
      order.update!(status: new_status) unless order.status == new_status
    end
  end
end
