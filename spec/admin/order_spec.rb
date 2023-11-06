require 'rails_helper'

RSpec.describe 'ActiveAdmin Order Form', type: :feature do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as(admin_user, scope: :admin_user)
  end

  describe 'Creating an Order' do
    it 'creates a new order' do
      create(:product, name: 'Exotic Meats Crate')

      visit new_admin_order_path

      select 'Exotic Meats Crate', from: 'order[product_id]', wait: 5

      fill_in 'order_customer_name', with: 'John Doe'
      fill_in 'order_address', with: '123 Main St'
      fill_in 'order_zip_code', with: '12345'
      fill_in 'order_shipping_method', with: 'Express'
      select 'processing', from: 'order[status]'

      click_button 'Create Order'

      expect(page).to have_content('Order was successfully created.')
    end
  end

  describe 'Editing an Order' do
    let!(:order) { create(:order) }

    it 'edits an existing order' do
      visit edit_admin_order_path(order)

      fill_in 'order_customer_name', with: 'Updated Customer'
      click_button 'Update Order'

      expect(page).to have_content('Order was successfully updated.')
      expect(page).to have_content('Updated Customer')
    end
  end

  describe 'Deleting an Order' do
    let!(:order) { create(:order) }

    it 'deletes an existing order' do
      visit admin_orders_path

      click_link 'Delete', href: admin_order_path(order)

      expect(page).to have_content('Order was successfully destroyed.')
    end
  end
end
