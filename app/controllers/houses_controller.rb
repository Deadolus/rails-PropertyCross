class HousesController < ApplicationController
    layout "application_no_title"
  def show
      @id = params[:id]
      #Proper REST-application and no database - so get Listing again...
      if params[:listing_location]
      @house = Listing.get_properties(params[:listing_location])[@id.to_i]
      else
      @house = Listing.get_location(params[:latitude], params[:longitude])[@id.to_i]
      end
  end
end
