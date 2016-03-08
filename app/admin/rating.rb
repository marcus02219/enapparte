ActiveAdmin.register Rating do
  permit_params :value, :review_id, :user_id
  form do |f|
    f.inputs "Rating" do
      f.input :value
      f.input :review
      f.input :user
    end
    f.actions
  end
  show do |rating|
    attributes_table do
      row :value
      row :review do
        link_to admin_review_path(rating.review) if rating.review
      end
      row :user do
        link_to rating.user.full_name, admin_user_path(rating.user) if rating.user
      end
      row :created_at
      row :updated_at
    end
  end
  index do
    selectable_column
    id_column
    column :review do |rating|
      link_to admin_review_path(rating.review) if rating.review
    end
    column :created_at
    column :updated_at
    actions
  end
end
