ActiveAdmin.register Rating do
  permit_params :value, :booking_id
  form do |f|
    f.inputs "Rating" do
      f.input :value
      f.input :booking
    end
    f.actions
  end
  show do |rating|
    attributes_table do
      row :value
      row :booking do
        link_to admin_booking_path(rating.booking) if rating.booking
      end
      row :created_at
      row :updated_at
    end
  end
  index do
    selectable_column
    id_column
    column :booking do |rating|
      link_to admin_booking_path(rating.booking) if rating.booking
    end
    column :created_at
    column :updated_at
    actions
  end
end
