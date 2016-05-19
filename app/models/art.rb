class Art < ActiveRecord::Base
  has_many :users

  validates :title, presence: true
  validates :user, presence: true
  validate :user_is_performer, if: 'user.present?'

  def user_is_performer
    errors.add(:base, 'A user should be performer') unless user.performer?
  end
end

# == Schema Information
#
# Table name: arts
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
