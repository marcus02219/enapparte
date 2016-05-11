ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Bookings' do
          ul do
            Booking.last(20).map do |comment|
              li link_to(admin_booking_path(comment), admin_booking_path(comment))
            end
          end
        end
      end
    end
  end
end
