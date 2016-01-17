class Language < ActiveRecord::Base
  has_many :users
  has_many :shows
end
