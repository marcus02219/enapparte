class Rating < ActiveRecord::Base

  DEFAULT_VALUE = 5

  belongs_to :review, inverse_of: :rating
  belongs_to :user
  # belongs_to :show
  has_one :booking, through: :review
  after_save :touch_show
  after_destroy :touch_show

  validates :review, :value, presence: true

  # before_save :set_show
  # before_save :set_user

  # def set_show
  #   show_id = review.booking.show.id
  # end

  # def set_user
  #   user_id = review.user.id
  # end

  private

  def touch_show
    review.try(:booking).try(:show).try(:update_attribute, :updated_at, Time.now)
  end
end

# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  value      :integer
#  review_id  :integer
#  user_id    :integer
#  booking_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ratings_on_booking_id  (booking_id)
#  index_ratings_on_review_id   (review_id)
#  index_ratings_on_user_id     (user_id)
#
