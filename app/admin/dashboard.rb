# app/admin/dashboard.rb

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Orders' do
          render partial: 'admin/orders/index', locals: { orders: Order.recent }
        end
      end
    end
  end
end
