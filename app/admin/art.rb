ActiveAdmin.register Art do
  permit_params :user_id, :title, :description

  index do
    selectable_column
    id_column
    column :user
    column :title
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Art' do
      f.semantic_errors *f.object.errors.keys
      f.input :user, as: :select, collection: User.performers
      f.input :title
      f.input :description
    end
    f.actions
  end

  show do |art|
    attributes_table do
      row :user
      row :title
      row :description
      row :created_at
      row :updated_at
    end
  end
end
