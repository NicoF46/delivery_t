class UpdateShippingStatusJob < ActiveJob::Base
  queue_as :default

  def perform
    orders_updates = {}
    Order.where.not(status: :delivered).find_each(batch_size: 100) do |order|
      orders_updates[order.id] = OrdersHelper::OrderUpdater.new(order).update_shipping_status
    rescue StandardError => e
      Rails.logger.error("Error updating shipping status for order #{order.id}: #{e.message}")
    end
    return if orders_updates.empty?

    BulkHelper::OrderUpdater.new(orders_updates).perform
    OrderStatusUpdateMailer.notify_order_status_update(orders_updates).deliver_now
  end
end
