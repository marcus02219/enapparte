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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  firstname              :string
#  surname                :string
#  gender                 :integer
#  sex                    :integer
#  bio                    :text
#  phone_number           :string
#  provider               :string
#  uid                    :integer
#  dob                    :date
#  activity               :string
#  language_id            :integer
#  addresses_id           :integer
#  bookings_id            :integer
#  payment_methods_id     :integer
#  shows_id               :integer
#  picture_id             :integer
#  rating                 :float
#  role                   :integer          default(1)
#  mobile                 :boolean
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :language

  has_many   :addresses
  accepts_nested_attributes_for :addresses, reject_if: :reject_addresses

  has_many   :bookings
  has_many   :payment_methods
  has_many   :shows
  has_one    :picture , as: :imageable

  validates :firstname, :surname, :gender, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  # validates :phone_number, format: { with: /\d{10}/, message: "bad format" }

  has_many :show_bookings, through: :shows, source: :bookings
  has_many :ratings, through: :show_bookings
  before_save :recalculate_rating
  before_save :deactivate_shows

  enum gender: { male: 0, female: 1, other: 2 }

  def comments
    self.shows.inject([]) {|comments, s| comments += s.bookings.map {|b| b.comment} }
  end

  def sent_comments
    self.bookings.inject([]) {|comments, b| comments << b.comment }
  end

  def full_name
    "#{firstname} #{surname}"
  end

  before_save :check_picture_exists

  def current_bookings
    self.bookings.where('date >= ? and (status = 1 or status = 2)', Time.now).order('date desc')
  end

  def old_bookings
    self.bookings.where('date < ? and (status = 1)', Time.now).order('date desc')
  end

  def cancelled_bookings
    self.bookings.where('(status = 3 or status = 4)', Time.now).order('date desc')
  end

  private

  def check_picture_exists
    self.build_picture  if self.picture.nil?
  end

  def recalculate_rating
    self.rating = 1.0 * self.ratings.sum(:value) / self.ratings.size  if self.ratings.size > 0
  end

  def reject_addresses attrs
    attrs['country'].blank? && attrs['postcode'].blank? && attrs['state'].blank? && attrs['city'].blank? && attrs['street'].blank?
  end

  def deactivate_shows
    self.shows.update_all(active: false)  unless self.phone_number.present?
  end
end
