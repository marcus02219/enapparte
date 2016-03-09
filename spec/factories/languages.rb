# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_languages_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :language do
    title "MyString"
  end

end
