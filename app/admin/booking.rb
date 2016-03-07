ActiveAdmin.register Booking do
  permit_params :status, :spectators, :price, :message, :payout, :payment_received?,
    :date_date, :date_time_hour, :date_time_minute,
    :paid_on_date, :paid_on_time_hour, :paid_on_time_minute,
    :paid_out_on_date, :paid_out_on_time_hour, :paid_out_on_time_minute,
    :payment_sent?, :paid_on , :paid_out_on, :show_id, :user_id, :address_id, :comment_id,
    :payment_method_id, :rating_ids => []
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
      # f.input :payment_method
      f.input :ratings
      # f.input :comment
    end
    f.actions
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
