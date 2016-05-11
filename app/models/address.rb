class Address < ActiveRecord::Base
  belongs_to :user
  has_many   :bookings
  # validates_format_of :postcode , :allow_blank => true, with: /\A\d{5}-\d{4}|\A\d{5}\z/, :message => "bad format (12345-1234 or 12345)"

  def full_address
    [country, state, street, city].select {|e| e.present? }.join(', ')
  end
  alias_method :name, :full_address
  geocoded_by :full_address
  after_validation :geocode

  # before_save :set_is_primary

  private

  def set_is_primary
    if user
      addresses = Address.where user: user
      if self.is_primary
        addresses.update_all is_primary: false
      else
        unless addresses.any? {|a| a.is_primary }
          self.is_primary = true
        end
      end
    end
  end

end

# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  street     :string
#  postcode   :string
#  city       :string
#  state      :string
#  country    :string
#  latitude   :float
#  longitude  :float
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_primary :boolean          default(FALSE)
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
