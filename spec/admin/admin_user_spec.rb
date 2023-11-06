require 'rails_helper'

RSpec.describe 'Admin Users Admin Panel', type: :feature do
  let(:admin_user) { create(:admin_user) }
  let!(:another_admin) { create(:admin_user) }
  before do
    login_as(admin_user, scope: :admin_user)
  end

  describe 'Index Page' do
    it 'displays the list of admin users' do
      visit admin_admin_users_path
      expect(page).to have_content('Admin Users')
      expect(page).to have_content(admin_user.email)
    end
  end

  describe 'Show Page' do
    it 'displays details of an admin user' do
      visit admin_admin_user_path(admin_user)
      expect(page).to have_content(admin_user.email)
    end
  end

  describe 'New Page' do
    it 'creates a new admin user' do
      visit new_admin_admin_user_path
      fill_in 'admin_user_email', with: 'new_admin@example.com'
      fill_in 'admin_user_password', with: 'password123'
      fill_in 'admin_user_password_confirmation', with: 'password123'
      click_button 'Create Admin user'
      expect(page).to have_content('Admin user was successfully created.')
    end
  end

  describe 'Edit Page' do
    it 'edits an existing admin user' do
      visit edit_admin_admin_user_path(admin_user)
      fill_in 'admin_user_email', with: 'updated_admin@example.com'
      click_button 'Update Admin user'
      expect(page).to have_content('Admin user was successfully updated.')
    end
  end

  describe 'Delete Action' do
    it 'deletes an existing admin user' do
      visit admin_admin_users_path
      click_link 'Delete', href: admin_admin_user_path(another_admin)
      expect(page).to have_content('Admin user was successfully destroyed.')
    end
  end
end
