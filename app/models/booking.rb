class Booking < ActiveRecord::Base
  belongs_to :show
  belongs_to :user
  belongs_to :address
  belongs_to :payment_method
  has_many   :ratings
  has_one    :comment
end
