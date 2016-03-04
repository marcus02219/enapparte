ActiveAdmin.register Comment, as: "Booking Comment" do
  permit_params :content, :booking_id

  form do |f|
    f.inputs "Booking Comment" do
      f.input :content
      f.input :booking
    end
    f.actions
  end
  show do |comment|
    attributes_table do
      row :content
      row :booking do
        link_to admin_booking_path(comment.booking) if comment.booking
      end
      row :created_at
      row :updated_at
    end
  end
  index do
    selectable_column
    id_column
    column :content do |comment|
      comment.content[0..300]
    end
    column :booking do |comment|
      link_to admin_booking_path(comment.booking) if comment.booking
    end
    column :created_at
    column :updated_at
    actions
  end
end
