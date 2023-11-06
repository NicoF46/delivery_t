require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as(admin_user, scope: :admin_user)
    visit admin_dashboard_path
  end

  it 'displays recent orders' do
    expect(page).to have_content('Recent Orders')
  end
end
