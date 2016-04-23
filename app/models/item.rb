class Item < ActiveRecord::Base
  before_save :geocode
  geocoder_init(latitude: :latitude, :longitude => :longitude)

  belongs_to :user
  delegate :email, to: :user

  def self.open
    where(closed: false)
  end

  def geocode
    return unless location_changed?

    if longitude_changed? || latitude_changed?
      result = Geocoder.search(lat: latitude, lon: longitude).first
    else
      result = Geocoder.search(location).first
      self.latitude = result.latitude
      self.longitude = result.longitude
    end

    self.city = result.city
  end
end
