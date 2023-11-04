class Order < ApplicationRecord
  enum status: {
    processing: 0,
    awaiting_pickup: 1,
    in_transit: 2,
    out_for_delivery: 3,
    delivered: 4
  }

  belongs_to :product

  validates :product_id, presence: true
  validates :customer_name, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :shipping_method, presence: true
end
