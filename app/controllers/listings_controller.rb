class ListingsController < ApplicationController
    def new
        @recentsearches = session[:recentsearches]
        #if @recentsearches then
        #    #params[:recentsearches] += @location+","
        #end
    end

    def show
        @page = params.has_key?(:page) ? params[:page] : 1
        if params[:location]
            location = params[:location].blank? ? "" : params[:location].capitalize
            #Generate a valid url, chop the id (0) from the string
            @url = listing_short_house_path(location, 0).chop
            @propertylistings, @total_number = Listing.get_properties_with_total_number(location, @page)
            if @propertylistings.any? then 
                (session[:recentsearches] ||= []) << params[:location].downcase
                session[:recentsearches].uniq!
            end
        else 
            #search with lat/lon
            @latitude = params[:latitude]
            @longitude = params[:longitude]
            @propertylistings, @total_number = Listing.get_location_with_total_number(@latitude, @longitude, @page)
            @url = location_listing_path(@latitude, @longitude)+"/"
            @location = params[:latitude]+"/".html_safe+params[:longitude]
            if @propertylistings.any? then 
                (session[:recentsearches] ||= []) << params[:latitude]+"/"+params[:longitude].downcase
                session[:recentsearches].uniq!
            end
        end
    end

    def create
        if params["search"] then 
            if params["search"]["location_based"] && params["search"]["location_based"] == 'true' then
                if request.location && request.location.latitude && request.location.longitude then
                    redirect_to location_listing_url(latitude: request.location.latitude, longitude: request.location.longitude)
                else
                    flash[:alert] = "Was not able to determine your location, please try again later"
                    redirect_to root_path
                end
                return
            end
            if params["search"]["location"] && !params["search"]["location"].blank? then
                #redirect_to action: :show, location: params["search"]["location"] || ""
                redirect_to listing_url(params["search"]["location"])
            else
                redirect_to root_path
                flash[:alert] = "Invalid search"
            end
        end
    end

    def create_location_based
        #redirect_to listing_url(request.location.latitude, request.location.longitude)
        redirect_to root_path
        flash[:alert] = "Not yet implemented"
    end
end
