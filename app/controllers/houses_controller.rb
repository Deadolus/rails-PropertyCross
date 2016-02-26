class HousesController < ApplicationController
    layout "application_no_title"
  def show
      @id = params[:id].to_i
      #Proper REST-application and no database - so get Listing again...
      if params[:listing_location]
      @house = Listing.get_house(params[:listing_location], @id)
      else
      @house = Listing.get_location_house(params[:latitude], params[:longitude], @id)
      end
  end
end
