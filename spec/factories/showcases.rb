FactoryGirl.define do
  factory :showcase do
    url 'http://yandex.ru'
  end
end

# == Schema Information
#
# Table name: showcases
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  kind       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
