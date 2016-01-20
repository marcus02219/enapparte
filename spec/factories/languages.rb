# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  title      :string
#  users_id   :integer
#  shows_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :language do
    title "MyString"
  end

end
