ActiveAdmin.register User do
  permit_params :email, :password, :firstname, :surname, :gender, :bio, :phone_number, :moving,
    :dob, :activity, :language_id, :picture, :role, 
    :address_ids => [], :booking_ids => [], :show_ids => [], :rating_ids => []
  index do
    selectable_column
    id_column
    column :email
    column :full_name
    column :phone_number
    column :created_at
    column :updated_at
    actions
  end
  form do |f|
    f.inputs "User" do
      f.input :email
      f.input :password
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
        hint: (image_tag(f.object.picture.image.url(:thumb)) if f.object.picture)
      f.input :ratings
      f.input :role, as: :select, collection: User.roles.keys
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
      row :language do
        link_to user.language.title, admin_language_path(user.language) if user.language
      end
      row :bookings do
        user.bookings.map{ |b| link_to admin_booking_path(b) }.join(', ').html_safe
      end
      row :shows do
        user.shows.map{ |b| link_to b.title, admin_show_path(b) }.join(', ').html_safe
      end
      row :ratings do
        user.ratings.map{ |b| link_to b.value, admin_rating_path(b) }.join(', ').html_safe
      end
      row :role
      row :picture do
        image_tag user.picture.image.url(:thumb) if user.picture
      end

      row :created_at
      row :updated_at
      row :sign_in_count
      row :last_sign_in_at
      row :last_sign_in_ip
    end
  end
end
