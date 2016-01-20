# == Schema Information
#
# Table name: payment_methods
#
#  id          :integer          not null, primary key
#  payoption   :string
#  provider    :string
#  user_id     :integer
#  bookings_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
