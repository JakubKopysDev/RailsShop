ActiveAdmin.register User do
  permit_params :email, :name, :password, :password_confirmation

  index do
    selectable_column
    column :id
    column :name
    column :email
    actions
  end

  form do |f|
    f.inputs 'User info' do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  filter :id
  filter :name
  filter :email
  filter :created_at
end
