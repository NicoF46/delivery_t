module OrdersHelper
  class OrderUpdater
    def initialize(order)
      @order = order
    end

    def update_shipping_status
      if @order.status == 'processing'
        shipment = Fedex::Shipment.create
        { status: shipment.status, external_tracking_id: shipment.id.to_s }
      else
        shipment = Fedex::Shipment.find(@order.external_tracking_id.to_i)
        new_status = shipment.status
        { status: new_status } unless @order.status == new_status
      end
    end
  end
end
