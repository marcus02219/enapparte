ActiveAdmin.register Language do
  permit_params :title, :user_id
  form do |f|
    f.inputs "Language" do
      f.input :title
      f.input :user
    end
    f.actions
  end
  show do |language|
    attributes_table do
      row :title
      row :user do
        link_to language.user.full_name, admin_user_path(language.user) if language.user
      end
      row :created_at
      row :updated_at
    end
  end
end
