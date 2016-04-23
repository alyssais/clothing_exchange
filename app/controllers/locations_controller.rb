class LocationsController < ApplicationController
  def index
    @locations = Item.uniq.pluck(:location)
  end

  def show
    @location = params[:id]
    @items = Item.where(location: @location)
  end
end
