ActiveAdmin.register Setting do
  permit_params :var, :value, :thing
  form do |f|
    f.inputs "Setting" do
      f.input :var
      f.input :value
    end
    f.actions
  end
  index do
    selectable_column
    id_column
    column :var
    column :value
    column :created_at
    column :updated_at
    actions
  end
  show do |art|
    attributes_table do
      row :var
      row :value
      row :created_at
      row :updated_at
    end
  end
end
