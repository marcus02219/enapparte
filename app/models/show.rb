# == Schema Information
#
# Table name: shows
#
#  id               :integer          not null, primary key
#  title            :string
#  length           :integer
#  description      :text
#  price            :float
#  max_spectators   :integer
#  active           :boolean
#  user_id          :integer
#  art_id           :integer
#  language_id      :integer
#  bookings_id      :integer
#  pictures_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cover_picture_id :integer
#  published_at     :datetime
#  starts_at        :string
#  ends_at          :string
#  rating           :float
#

class Show < ActiveRecord::Base
  belongs_to :art
  belongs_to :user
  belongs_to :language
  has_many   :bookings  , dependent: :destroy
  belongs_to :cover_picture, class_name: 'Picture'

  validates :art_id, :max_spectators, :length, :title, :description, :language_id, :price, presence: true

  has_many   :pictures  , dependent: :destroy , as: :imageable
  accepts_nested_attributes_for :pictures, allow_destroy: true

  has_many :ratings, through: :bookings

  after_save :set_cover_picture
  before_save :recalculate_rating

  def toggle_active
    if user && user.confirmed? && user.addresses.any? && user.phone_number.present?
      self.active = !self.active
      self.save
    else
      if user.addresses.empty?
        self.errors.add(:address, I18n.t('activerecord.errors.messages.addresses_is_empty'))
      elsif user.phone_number.blank?
        self.errors.add(:phone_number, I18n.t('activerecord.errors.messages.phone_number_is_empty'))
      end
    end
  end

  private

  def set_cover_picture
    picture = self.pictures.select { |p| p.selected }.first
    if picture && picture.id != cover_picture_id
      self.cover_picture = picture
      self.save
    end
  end

  def recalculate_rating
    self.rating = 1.0 * self.ratings.sum(:value) / self.ratings.size  if self.ratings.size > 0
  end

end
