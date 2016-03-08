class Review < ActiveRecord::Base
  belongs_to :booking
  has_one :rating, dependent: :destroy, inverse_of: :review
  
  accepts_nested_attributes_for :rating

  validates :review, presence: true
  validates_associated :rating
  validates_presence_of :rating
end
