ActiveAdmin.register Product do
  permit_params :name, :description, :price, :image

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
    column :created_at
    actions
  end

  show do |product|
    attributes_table do
      row :name
      row :description
      row :price
      row :image do |prodcut|
        image_tag product.image(:medium), class: 'admin-thumbnail'
      end
      row :image_urls do |product|
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
  end

  form do |f|
    f.inputs 'Product data' do
      f.input :name
      f.input :description
      f.input :price
      f.input :image
    end
    f.actions
  end

  filter :id
  filter :name
  filter :description
  filter :price
  filter :created_at
end
