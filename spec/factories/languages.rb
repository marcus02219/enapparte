FactoryGirl.define do
  factory :language do
    title Faker::Address.country
  end
end

# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
