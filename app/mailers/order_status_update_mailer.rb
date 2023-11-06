class OrderStatusUpdateMailer < ApplicationMailer
  def notify_order_status_update(order_changes)
    @orders = order_changes
    mail(to: ENV['MANAGER_EMAIL'], subject: 'Order Status Update')
  end
end
