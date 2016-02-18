# == Schema Information
#
# Table name: arts
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  shows_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :art do
    title "MyString"
    description "MyText"
  end

end
