module BulkHelper
  class OrderUpdater
    def initialize(updates)
      @updates = updates
    end

    def perform
      return if @updates.empty?

      update_statement = @updates.map do |order_id, values|
        status_update = "status = #{Order.statuses[values[:status]]}"
        tracking_id_update = values[:external_tracking_id] ? "external_tracking_id = '#{values[:external_tracking_id]}'" : nil
        updates = [status_update, tracking_id_update].compact.join(', ')

        "UPDATE orders SET #{updates} WHERE id = #{order_id};"
      end

      ActiveRecord::Base.connection.execute(update_statement.join("\n"))
    end
  end
end
