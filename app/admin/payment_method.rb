ActiveAdmin.register PaymentMethod do
  permit_params :payoption, :provider, :user_id, booking_ids: []
  form do |f|
    f.inputs "Payment Method" do
      f.input :payoption
      f.input :provider
      f.input :user
      f.input :bookings
    end
    f.actions
  end
  show do |pm|
    attributes_table do
      row :payoption
      row :provider
      row :user do
        link_to pm.user.full_name, admin_user_path(pm.user) if pm.user
      end
      row :bookings do
        pm.bookings.map{ |b| link_to admin_booking_path(b) }.join(', ').html_safe
      end
      row :created_at
      row :updated_at
    end
  end
  index do
    selectable_column
    id_column
    column :payoption
    column :provider
    column :user do |address|
      link_to address.user.full_name, admin_user_path(address.user) if address.user
    end
    column :created_at
    column :updated_at
    actions
  end
end
