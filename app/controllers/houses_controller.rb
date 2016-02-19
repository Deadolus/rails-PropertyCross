class HousesController < ApplicationController
  def show
      @id = params[:id]
      #Proper REST-application and no database - so get Listing again...
      @house = Listing.get_properties(params[:listing_location])[@id.to_i]
  end
end
