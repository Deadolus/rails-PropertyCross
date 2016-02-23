class HousesController < ApplicationController
    layout "application_no_title"
  def show
      @id = params[:id]
      #Proper REST-application and no database - so get Listing again...
      @house = Listing.get_properties(params[:listing_location])[@id.to_i]
      @listing_location = params[:listing_location]
  end
end
