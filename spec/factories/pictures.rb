FactoryGirl.define do
  factory :picture do
    title "MyString"
  end

end

# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  title              :string
#  selected           :boolean
#  imageable_type     :string
#  imageable_id       :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#
# Indexes
#
#  index_pictures_on_imageable_type_and_imageable_id  (imageable_type,imageable_id)
#
