ActiveAdmin.register Booking do
  permit_params :status, :spectators, :price, :message, :payout, :payment_received?,
    :date_date, :date_time_hour, :date_time_minute,
    :paid_on_date, :paid_on_time_hour, :paid_on_time_minute,
    :paid_out_on_date, :paid_out_on_time_hour, :paid_out_on_time_minute,
    :payment_sent?, :show_id, :user_id, :address_id
  form do |f|
    f.inputs "Booking" do
      f.input :status
      f.input :date, as: :just_datetime_picker
      f.input :spectators
      f.input :price
      f.input :message
      f.input :payout
      f.input :payment_received?
      f.input :payment_sent?
      f.input :paid_on, as: :just_datetime_picker
      f.input :paid_out_on, as: :just_datetime_picker
      f.input :show
      f.input :user
      f.input :address
    end
    f.actions
  end

  show do |booking|
    attributes_table do
      row :status
      row :date
      row :spectators
      row :price
      row :message
      row :payout
      row :payout
      row :payment_received?
      row :payment_sent?
      row :paid_on
      row :paid_out_on
      row :show do
        link_to booking.show.title, admin_show_path(booking.show) if booking.show
      end
      row :user do
        link_to booking.user.full_name, admin_user_path(booking.user) if booking.user
      end
      row :address do
        link_to booking.address.full_address, admin_address_path(booking.address) if booking.address
      end
      row :created_at
      row :updated_at
    end
  end

  index do
    selectable_column
    id_column
    column :price
    column :date
    column :payment_received?
    column :payment_sent?
    column :user do |booking|
      link_to booking.user.full_name, admin_user_path(booking.user) if booking.user
    end
    column :show do |booking|
      link_to booking.show.title, admin_user_path(booking.show) if booking.show
    end
    column :created_at
    column :updated_at
    actions
  end
end
