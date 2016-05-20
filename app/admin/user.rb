ActiveAdmin.register User do
  permit_params :email, :password, :firstname, :surname, :gender, :bio,
                :phone_number, :moving, :dob, :activity, :picture, :role, :art_id,
                address_ids: [], booking_ids: [], show_ids: [], rating_ids: [],
                language_ids: [], showcases_attributes: [:id, :kind, :url],
                availabilities_attributes: [:available_at]
  index do
    selectable_column
    id_column
    column :email
    column :role
    column :full_name
    column :phone_number
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :role
  filter :full_name

  form do |f|
    f.inputs 'User' do
      f.input :email
      f.input :password if f.object.new_record?
      f.input :firstname
      f.input :surname
      f.input :gender, as: :select, collection: User.genders.keys
      f.input :bio
      f.input :phone_number
      f.input :dob, as: :datepicker
      f.input :activity
      f.input :moving
      f.input :addresses
      f.input :bookings
      f.input :shows
      f.input :picture, as: :file,
                        hint: (image_tag(f.object.picture.image
                                             .url(:thumb)) if f.object.picture)
      f.input :role, as: :select, collection: User.roles.keys
      f.has_many :showcases, heading: false, allow_destroy: true do |s|
        s.input :kind
        s.input :url
      end
      f.has_many :availabilities, heading: false, allow_destroy: true do |s|
        s.input :available_at
      end
      f.input :art
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :email
      row :full_name
      row :gender
      row :bio
      row :phone_number
      row :moving
      row :dob
      row :activity
      table_for user.languages.order('title ASC') do
        column :languages do |language|
          link_to language.title, admin_language_path(language)
        end
      end
      row :bookings do
        user.bookings.map do |b|
          link_to admin_booking_path(b)
        end.join(', ').html_safe
      end
      row :shows do
        user.shows.map do |b|
          link_to b.title, admin_show_path(b)
        end.join(', ').html_safe
      end
      row :ratings do
        user.ratings.map do |b|
          link_to b.value, admin_rating_path(b)
        end.join(', ').html_safe
      end
      row :role
      row :picture do
        image_tag user.picture.image.url(:thumb) if user.picture
      end
      table_for user.showcases do
        column :showcases do |showcase|
          raw(showcase.kind + ': ' +
                  link_to(showcase.url, showcase.url, target: '_blank'))
        end
      end
      row :art do
        link_to user.art.title, admin_art_path(user.art) if user.art
      end

      row :created_at
      row :updated_at
      row :sign_in_count
      row :last_sign_in_at
      row :last_sign_in_ip
    end
  end
end
