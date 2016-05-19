class UserAvailability < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :available_at, presence: true
end

# == Schema Information
#
# Table name: user_availabilities
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  available_at :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
