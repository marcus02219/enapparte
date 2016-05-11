class Language < ActiveRecord::Base
  has_and_belongs_to_many :users
end

# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
