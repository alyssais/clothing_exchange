class LocationsController < ApplicationController
  def index
    @locations = Item.uniq.pluck(:location)
  end
end
