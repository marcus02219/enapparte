ActiveAdmin.register Language do
  permit_params :title, :user_id
  form do |f|
    f.inputs "Language" do
      f.input :title
    end
    f.actions
  end
  show do |language|
    attributes_table do
      row :title
      row :created_at
      row :updated_at
    end
  end
end
