ActiveAdmin.register Picture do
  permit_params :title, :image, :selected, :imageable_type, :imageable_id
  form do |f|
    f.inputs "Picture" do
      f.input :title
      f.input :image, as: :file, hint: image_tag(f.object.image.url(:thumb))
      f.input :selected
      f.input :imageable_type
      f.input :imageable_id
      actions
    end
  end
  index do
    selectable_column
    id_column
    column :title
    column :image do |img|
      image_tag img.image.url(:thumb)
    end
    column :imageable
    column :selected
    column :created_at
    column :updated_at
    actions
  end

  show do |picture|
    attributes_table do
      row :title
      row :selected
      row :imageable
      row :image do
        image_tag picture.image.url(:thumb) if picture.image?
      end
      row :created_at
      row :updated_at
    end
  end

end
