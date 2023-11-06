RSpec.describe 'ActiveAdmin User Form', type: :feature do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as(admin_user, scope: :admin_user)
  end

  describe 'New Page' do
    it 'creates a new user' do
      visit new_admin_user_path
      fill_in 'user_email', with: 'new_user@example.com'
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'password123'
      click_button 'Create User'
      expect(page).to have_content('User was successfully created.')
    end
  end

  describe 'Edit Page' do
    let!(:user) { create(:user) }

    it 'edits an existing user' do
      visit edit_admin_user_path(user)
      fill_in 'user_email', with: 'updated_user@example.com'
      click_button 'Update User'
      expect(page).to have_content('User was successfully updated.')
    end
  end
end
