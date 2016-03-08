class Show < ActiveRecord::Base
  belongs_to :art
  belongs_to :user
  has_many   :bookings
  belongs_to :cover_picture, class_name: 'Picture'
  has_many   :pictures  , dependent: :destroy , as: :imageable
  has_many :reviews, through: :ratings
  has_many :ratings

  just_define_datetime_picker :published_at
  validates :art_id, :max_spectators, :length, :title, :description, :language_id, :price, presence: true

  accepts_nested_attributes_for :pictures, allow_destroy: true

  after_save :set_cover_picture

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  def as_indexed_json options={}
    self.as_json({
      only: [:title, :description]
    })
  end
  
  def rating
    [ratings.average(:value).to_i, 5].min
  end
  
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


end
