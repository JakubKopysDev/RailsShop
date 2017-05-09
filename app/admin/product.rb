# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params :name, :description, :price, :image, category_ids: []
  menu priority: 2

  config.per_page = 4
  config.sort_order = 'desc'

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :price
    column :image do |product|
      image_tag product.image(:medium), class: 'admin-thumbnail'
    end
    column :categories do |product|
      product.categories.pluck(:name).join(', ')
    end
    column :created_at
    actions
  end

  show do |product|
    attributes_table do
      row :name
      row :description
      row :price
      row :categories do
        product.categories.pluck(:name).join(', ')
      end
      row :image do
        image_tag product.image(:medium), class: 'admin-thumbnail'
      end
      row :image_urls do
        columns do
          column do
            link_to "Original: #{product.image}", product.image.url
          end
          column do
            link_to "Medium: #{product.image(:medium)}", product.image(:medium)
          end
        end
      end
      row :image_file_name
      row :image_content_type
      row :image_file_size
      row :image_updated_at
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Product data' do
      categories_collection = Category.all.collect { |c| [c.name, c.id] }

      f.input :name
      f.input :description
      f.input :price
      f.input :image
      f.input :categories, collection: categories_collection, as: :select
    end
    f.actions
  end

  filter :id
  filter :name
  filter :description
  filter :categories
  filter :price
  filter :created_at
end
