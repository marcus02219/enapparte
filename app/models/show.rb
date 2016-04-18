# == Schema Information
#
# Table name: shows
#
#  id               :integer          not null, primary key
#  title            :string
#  length           :integer
#  surface          :integer
#  description      :text
#  price            :float
#  max_spectators   :integer
#  starts_at        :string
#  ends_at          :string
#  active           :boolean
#  published_at     :datetime
#  cover_picture_id :integer
#  user_id          :integer
#  art_id           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  rating           :float
#
# Indexes
#
#  index_shows_on_art_id            (art_id)
#  index_shows_on_cover_picture_id  (cover_picture_id)
#  index_shows_on_user_id           (user_id)
#

class Show < ActiveRecord::Base

  COMMISSION = 1.1

  belongs_to :art
  belongs_to :cover_picture, class_name: 'Picture'

  belongs_to :user
  has_many :languages, through: :user

  has_many   :bookings
  has_many   :pictures  , dependent: :destroy , as: :imageable
  has_many :reviews, through: :bookings
  has_many :ratings, through: :reviews

  just_define_datetime_picker :published_at
  validates :art_id, :max_spectators, :length, :title, :description, :price, presence: true

  accepts_nested_attributes_for :pictures, allow_destroy: true

  after_save :set_cover_picture
  before_save :update_rating

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def as_indexed_json options={}
    self.as_json({
                   only: [:title, :description]
    })
  end

  # def rating
  #   [ratings.average(:value).to_i, 5].min
  # end

  def toggle_active
    if user && user.addresses.any? && user.phone_number.present?
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

  def pictures=(array)
    array.each do |file|
      pictures.build(image: file)
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

  def update_rating
    self.rating = [ratings.average(:value).to_f, 5].min
  end
end
