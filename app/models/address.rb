class Address < ActiveRecord::Base
  belongs_to :user
  has_many   :bookings
  validates_format_of :postcode ,  with: /\A\d{5}-\d{4}|\A\d{5}\z/, :message => "bad format"
  
  def full_address
    "#{street}, #{city}"
  end
  geocoded_by :full_address
  after_validation :geocode
end
