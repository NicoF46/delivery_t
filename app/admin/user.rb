ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password, required: f.object.new_record?
      f.input :password_confirmation, required: f.object.new_record?
    end
    f.actions
  end
  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      super
    end
  end
end
