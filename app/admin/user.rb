# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :name, :password, :password_confirmation, :country,
                :city, :street, :post_code, :phone_number, :avatar,
                :credit_card_number, :credit_card_sec, :exp_date
  menu priority: 1

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :phone_number
    column :country
    column :city
    column :street
    column :post_code
    column 'Billing' do |user|
      span do
        "#{user.credit_card_number} #{user.credit_card_sec} #{user.exp_date}"
      end
    end
    actions defaults: false, dropdown: true do |user|
      item 'View', admin_user_path(user)
      item 'Delete', admin_user_path(user), method: :delete
    end
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
