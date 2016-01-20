# == Schema Information
#
# Table name: shows
#
#  id             :integer          not null, primary key
#  title          :string
#  length         :integer
#  description    :text
#  price          :float
#  max_spectators :integer
#  starts_at      :time
#  ends_at        :time
#  active         :boolean
#  user_id        :integer
#  art_id         :integer
#  language_id    :integer
#  bookings_id    :integer
#  pictures_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :show do
    title "MyString"
length 1
description "MyText"
price 1.5
max_spectators 1
starts_at "2016-01-17 05:17:54"
ends_at "2016-01-17 05:17:54"
actve false
  end

end
