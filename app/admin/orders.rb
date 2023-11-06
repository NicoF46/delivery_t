ActiveAdmin.register Order do
  permit_params :product_id, :customer_name, :address, :zip_code, :shipping_method, :status

  form do |f|
    f.inputs 'Order Details' do
      f.input :product, as: :select, collection: Product.all.map { |p| [p.name, p.id] }, include_blank: false
      f.input :customer_name
      f.input :address
      f.input :zip_code
      f.input :shipping_method
      f.input :status, as: :select, collection: Order.statuses.keys, include_blank: false
    end
    f.actions
  end
end
