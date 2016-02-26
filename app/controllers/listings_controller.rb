class ListingsController < ApplicationController
    def new
        @recentsearches = session[:recentsearches]
    end

    def show
        @page = params.has_key?(:page) ? params[:page] : 1
        if params[:location]
            location = params[:location].blank? ? "" : params[:location].capitalize
            #Generate a valid url, chop the id (0) from the string
            @url = listing_short_house_path(location, 0).chop
            @propertylistings, @total_number = Listing.get_properties_with_total_number(location, @page)
        else 
            #search with lat/lon
            @latitude = params[:latitude]
            @longitude = params[:longitude]
            location = params[:latitude]+"/".html_safe+params[:longitude]
            @url = location_listing_path(@latitude, @longitude)+"/"
            @propertylistings, @total_number = Listing.get_location_with_total_number(@latitude, @longitude, @page)
        end
        if @total_number.to_i > 0 then
                add_to_recent_searches(location, @total_number)
            else
                redirect_to root_path
                flash[:alert] = "There were no properties found for the given location."
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
                flash[:alert] = "The location given was not recognised"
            end
        end
    end

    def create_location_based
        #redirect_to listing_url(request.location.latitude, request.location.longitude)
        redirect_to root_path
        flash[:alert] = "Not yet implemented"
    end
    private

    #Can't add structs to session, so no advantages of using it here, create hash directly instead
    #Struct.new("Search", :name, :results)

    def add_to_recent_searches(name, results)
        (session[:recentsearches] ||= []) <<{'name' => name.downcase, 'results' =>results}
        session[:recentsearches].uniq!
        #Leave only the last 4 searches
        session[:recentsearches] = session[:recentsearches].last(4)
    end
end
