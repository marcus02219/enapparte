# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  firstname              :string
#  surname                :string
#  gender                 :integer
#  sex                    :integer
#  bio                    :text
#  phone_number           :string
#  provider               :string
#  uid                    :integer
#  dob                    :date
#  activity               :string
#  language_id            :integer
#  addresses_id           :integer
#  bookings_id            :integer
#  payment_methods_id     :integer
#  shows_id               :integer
#  picture_id             :integer
#  rating                 :float
#  role                   :integer          default(1)
#  mobile                 :boolean
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }

  before(:each) { sign_in user }

  context 'POST upload_photo' do
    before(:each) do
      photo = fixture_file_upload 'missing.png', 'image/png'
      post :upload_photo, image: photo
      user.picture.reload
    end

    it { expect(response).to be_success }
    it { expect(user.picture.image).to be_exists }
    it { expect(response.body).to include(user.picture.image.url(:medium)) }
  end
end
