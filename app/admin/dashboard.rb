# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Products' do
          ul do
            Product.order(created_at: 'desc').take(5).map do |product|
              li link_to(product.name, admin_product_path(product))
            end
          end
        end
      end

      column do
        panel 'Recent Users' do
          ul do
            User.order(created_at: 'desc').take(5).map do |user|
              li link_to(user.name, admin_user_path(user))
            end
          end
        end
      end
    end
  end
end
