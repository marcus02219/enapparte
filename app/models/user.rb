class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :language
  has_many   :addresses
  has_many   :bookings
  has_many   :payment_methods
  has_many   :shows
  has_one    :picture , as: :imageable
  validates :firstname, :surname, :gender, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :phone_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }



  def full_name
    "#{firstname} #{surname}"
  end
end
