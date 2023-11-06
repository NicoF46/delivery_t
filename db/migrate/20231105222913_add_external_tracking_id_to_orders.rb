class AddExternalTrackingIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :external_tracking_id, :string
  end
end
