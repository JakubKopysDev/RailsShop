# frozen_string_literal: true

ActiveAdmin.register Ticket do
  permit_params :content, :email, :name

  actions :index, :show, :edit, :update, :destroy

  config.sort_order = 'desc'

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :content
    column :created_at
    actions defaults: false, dropdown: true do |ticket|
      item 'View', admin_ticket_path(ticket)
      item 'Delete', admin_ticket_path(ticket), method: :delete
    end
  end

  form do |f|
    f.inputs 'Ticket' do
      f.input :content
    end
    f.actions
  end
end
