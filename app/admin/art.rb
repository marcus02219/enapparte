ActiveAdmin.register Art do
  permit_params :title, :description, :show_ids => []
  form do |f|
    f.inputs "Art" do
      f.input :title
      f.input :description
      f.input :shows
    end
    f.actions
  end
  index do
    selectable_column
    id_column
    column :title
    column :created_at
    column :updated_at
    actions
  end
  show do |art|
    attributes_table do
      row :title
      row :description
      row :shows do
        art.shows.map{|show| link_to show.title, admin_show_path(show)}.join(', ').html_safe
      end
      row :created_at
      row :updated_at
    end
  end
end
