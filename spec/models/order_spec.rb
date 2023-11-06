require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should define_enum_for(:status).with_values(%i[processing awaiting_pickup in_transit out_for_delivery delivered]) }
    it { should validate_presence_of(:product_id) }
    it { should validate_presence_of(:customer_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:shipping_method) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
  end
end
