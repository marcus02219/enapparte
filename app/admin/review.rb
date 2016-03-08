ActiveAdmin.register Review do
  permit_params :review, :booking_id, rating_attributes: [:value]

  form do |f|
    f.inputs "Booking review" do
      f.input :review
      f.input :booking
      f.inputs "Rating" do
        f.semantic_fields_for :rating, (f.object.rating || f.object.build_rating)  do |meta_form|
          meta_form.inputs :value
        end
      end
    end
    f.actions
  end
  show do |review|
    attributes_table do
      row :review
      row :booking do
        link_to admin_booking_path(review.booking) if review.booking
      end
      row :rating do
        link_to review.rating.value, admin_rating_path(review.rating)
      end
      row :created_at
      row :updated_at
    end
  end
  index do
    selectable_column
    id_column
    column :review do |review|
      review.review[0..300]
    end
    column :booking do |review|
      link_to admin_booking_path(review.booking) if review.booking
    end
    column :created_at
    column :updated_at
    actions
  end
end
