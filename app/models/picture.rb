class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  
  # PaperClip
  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/images/picture/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  attr_accessor :src
  def src
    self.image.url(:medium)
  end

  def src= data
    if data.include? 'base64,'
      content_type, image_data = data.split('base64,')
      decoded_data = Base64.decode64(image_data)

      data = StringIO.new(decoded_data)
      data.class_eval do
        attr_accessor :content_type, :original_filename
      end

      data.content_type = content_type.split('data:')[1]
      data.original_filename = File.basename('image.png')

      self.image = data
    end
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
