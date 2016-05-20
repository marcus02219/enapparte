class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum gender: { male: 0, female: 1, other: 2 }
  enum role: { admin: 0, user: 1, performer: 2 }

  has_one :picture, as: :imageable
  has_many :addresses
  has_many :bookings, dependent: :destroy
  has_many :shows, dependent: :destroy
  belongs_to :art
  has_many :ratings, through: :shows, source: :ratings
  has_many :show_bookings, through: :shows, source: :bookings
  has_many :reviews, through: :show_bookings
  has_many :payment_methods
  has_many :showcases, dependent: :destroy
  has_many :languages_user
  has_many :languages, through: :languages_user
  has_many :availabilities, class_name: 'UserAvailability', dependent: :destroy

  accepts_nested_attributes_for :picture, reject_if: proc { |attrs|
    attrs['src'].blank? || attrs['src'].match(/^http:/)
  }
  accepts_nested_attributes_for :addresses, reject_if: :reject_addresses
  accepts_nested_attributes_for :payment_methods,
                                reject_if: :reject_payment_methods
  accepts_nested_attributes_for :showcases
  accepts_nested_attributes_for :availabilities

  validates :firstname, :surname, presence: true
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  }
  validate :user_is_performer, if: 'art.present?'

  before_save :deactivate_shows
  before_save :check_picture_exists

  scope :performers, -> { where role: roles[:performer] }

  def picture=(file)
    build_picture(image: file)
  end

  def sent_reviews
    bookings.includes(:review).inject([]) do |reviews, b|
      reviews << b.review if b.review
    end
  end

  def full_name
    "#{firstname} #{surname}"
  end

  def current_bookings
    bookings
      .where('date >= ? and (status = 1 or status = 2)', Time.zone.now)
      .order('date desc')
  end

  def old_bookings
    bookings.where('date < ? and (status = 1)', Time.zone.now)
            .order('date desc')
  end

  def cancelled_bookings
    bookings.where('(status = 3 or status = 4)', Time.zone.now)
            .order('date desc')
  end

  def rating
    [ratings.average(:value).to_i, 5].min
  end

  def self.available_languages
    Language.select(:title, :id)
  end

  private

  def check_picture_exists
    build_picture if picture.nil?
  end

  def reject_addresses(attrs)
    attrs['country'].blank? && attrs['postcode'].blank? &&
      attrs['state'].blank? && attrs['city'].blank? && attrs['street'].blank?
  end

  def reject_payment_methods(attrs)
    attrs['stripe_token'].blank? && attrs['last4'].blank?
  end

  def deactivate_shows
    shows.update_all(active: false) unless phone_number.present?
  end

  def user_is_performer
    errors.add(:art, 'A user should be performer') unless performer?
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  role                   :integer          default(1)
#  firstname              :string
#  surname                :string
#  gender                 :integer
#  bio                    :text
#  phone_number           :string
#  dob                    :date
#  activity               :string
#  moving                 :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
