# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  title      :string
#  users_id   :integer
#  shows_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Language < ActiveRecord::Base
  has_many :users
  has_many :shows
end
