ActiveAdmin.register Address do
  permit_params :street, :postcode, :city, :state, :country, :latitude, :longitude, :user_id, :booking_ids => []
  form do |f|
    f.inputs "Address" do
      f.input :street
      f.input :postcode
      f.input :city
      f.input :state
      f.input :country, as: :string
      f.input :latitude
      f.input :longitude
      f.input :user
      f.input :bookings
    end
    f.actions
  end
  show do |address|
    attributes_table do
      row :street
      row :postcode
      row :city
      row :state
      row :country
      row :latitude
      row :longitude
      row :user do
        link_to address.user.full_name, admin_user_path(address.user) if address.user
      end
      row :bookings do
        address.bookings.map{ |b| link_to admin_booking_path(b) }.join(', ').html_safe
      end
      row :created_at
      row :updated_at
    end
  end
  index do
    selectable_column
    id_column
    column :full_address
    column :user do |address|
      link_to address.user.full_name, admin_user_path(address.user) if address.user
    end
    column :created_at
    column :updated_at
    actions
  end
end
