# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params(
    :name,
    :description,
    :price,
    category_ids: [],
    pictures_attributes: %i[id file _destroy]
  )

  menu priority: 2

  config.per_page = 4
  config.sort_order = 'desc'

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :price
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
      f.inputs do
        f.has_many :pictures, allow_destroy: true do |a|
          a.input :file
        end
      end
      f.input :categories, collection: categories_collection, as: :select
    end
    f.actions
  end

  controller do
    def create
      @product = Product.new(permitted_params[:product])

      if @product.save
        redirect_to admin_products_path
      else
        render :new
      end
    end
  end

  filter :id
  filter :name
  filter :description
  filter :categories
  filter :price
  filter :created_at
end
