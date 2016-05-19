class LanguagesUser < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
end

# == Schema Information
#
# Table name: languages_users
#
#  id          :integer          not null, primary key
#  language_id :integer
#  user_id     :integer
#
# Indexes
#
#  index_languages_users_on_language_id  (language_id)
#  index_languages_users_on_user_id      (user_id)
#
