class Review < ActiveRecord::Base
  belongs_to :booking, touch: true
  has_one :rating, dependent: :destroy, inverse_of: :review

  accepts_nested_attributes_for :rating

  validates :review, presence: true
  validates_associated :rating
  # validates_presence_of :rating

  def name
  	review[0..200] || id
  end

  private
end

# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  review     :text
#  booking_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reviews_on_booking_id  (booking_id)
#
