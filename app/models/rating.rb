class Rating < ActiveRecord::Base
  
  DEFAULT_VALUE = 5

  belongs_to :review, inverse_of: :rating
  belongs_to :user
  belongs_to :show
  after_save :touch_parent
  after_destroy :touch_parent

  validates :review, :value, presence: true
  
  before_save :set_show
  before_save :set_user

  def set_show
    self.show_id = review.booking.show.id
  end

  def set_user
    self.user_id = review.user.id
  end

  private

  def touch_parent
    if booking && booking.show
      booking.show.update_attribute(:updated_at, Time.now)
      if booking.show.user
        booking.show.user.update_attribute(:updated_at, Time.now)
      end
    end
  end
end