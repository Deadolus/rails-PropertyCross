class ListingsController < ApplicationController
  def new
      @recentsearches = session[:recentsearches]
      #if @recentsearches then
      #    #params[:recentsearches] += @location+","
      #end
  end

  def show
      @location = params[:location].blank? ? "" : params[:location].capitalize
      @propertylistings = Listing.get_properties(@location)
      if @propertylistings.any? then 
          (session[:recentsearches] ||= []) << params[:location].downcase
          session[:recentsearches].uniq!
      end
  end

  def create
      if params["search"] && params["search"]["location"] && !params["search"]["location"].blank? then
      #redirect_to action: :show, location: params["search"]["location"] || ""
          redirect_to listing_url(params["search"]["location"])
      else
          redirect_to root_path
          flash[:alert] = "Invalid search"
      end
  end
end
