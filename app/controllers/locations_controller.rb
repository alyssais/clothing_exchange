class LocationsController < ApplicationController
  def index
    @locations = Item.uniq.pluck(:location).sort
  end
end
