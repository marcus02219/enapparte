require 'rails_helper'

RSpec.describe Picture, type: :model do

  context 'base64 image' do

    context 'when src is base64 image data' do
      let(:data) { File.read(Rails.root.join('spec/fixtures/base64data.txt')) }
      let(:picture) { build :picture, src: data }
      before(:each) { picture.save }
      it { expect(picture.image.exists?).to eq true }
    end

    context 'when src is http source' do
      let(:picture) { build :picture, src: 'http://google.com/image.jpg' }
      before(:each) { picture.save }
      it { expect(picture.image.exists?).to eq false }
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
