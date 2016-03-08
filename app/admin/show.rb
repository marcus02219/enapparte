ActiveAdmin.register Show do
  permit_params :title, :length, :surface, :description, :price, :max_spectators, :active, :user_id, :art_id,
    :published_at_date, :published_at_time_hour, :published_at_time_minute, :starts_at,
    :ends_at, :booking_ids => [], :pictures => []

  form do |f|
    f.inputs "Show" do
      f.input :title
      f.input :length
      f.input :surface
      f.input :description
      f.input :price
      f.input :max_spectators
      f.input :starts_at
      f.input :ends_at
      f.input :active
      f.input :published_at, as: :just_datetime_picker
      f.input :user
      f.input :art
      f.input :bookings
      f.input :pictures, as: :file, input_html: { multiple: true }
      li id: 'pictures' do
        div class: 'inline-hints' do
          render(partial: 'active_admin/pictures', locals: { object: f.object, page: 'edit' })
        end
      end
    end
    f.actions
  end

  show do |show|
    attributes_table do
      row :title
      row :length
      row :surface
      row :description
      row :price
      row :max_spectators
      row :active
      row :user do
        link_to show.user.full_name, admin_user_path(show.user) if show.user
      end
      row :art do
        link_to show.art.title, admin_art_path(show.art) if show.art
      end
      row :language do
        link_to show.language.title, admin_language_path(show.language) if show.language
      end
      row :published_at
      row :starts_at
      row :ends_at
      row :bookings do
        show.bookings.map{ |b| link_to admin_booking_path(b) }.join(', ').html_safe
      end
      row :cover_picture do
        if show.cover_picture
          link_to show.cover_picture.image.url, target: '_blank' do
            image_tag show.cover_picture.image.url(:thumb)
          end
        end
      end
      row :pictures do
        render(partial: 'active_admin/pictures', locals: { object: show, page: 'show' } )
      end
      row :created_at
      row :updated_at
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :price
    column :user do |show|
      link_to show.user.full_name, admin_user_path(show.user) if show.user
    end
    column :created_at
    column :updated_at
    actions
  end

end
