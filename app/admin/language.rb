ActiveAdmin.register Language do
  permit_params :title, :user_ids => [], :show_ids => []
  form do |f|
    f.inputs "Language" do
      f.input :title
      f.input :users
      f.input :shows
    end
    f.actions
  end
  show do |language|
    attributes_table do
      row :title
      row :users do
        language.users.map{|u| link_to u.full_name, admin_user_path(u)}.join(', ').html_safe
      end
      row :shows do
        language.shows.map{|show| link_to show.title, admin_show_path(u)}.join(', ').html_safe
      end
      row :created_at
      row :updated_at
    end
  end
end
