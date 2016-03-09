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

class Art < ActiveRecord::Base
  has_many :shows
end
