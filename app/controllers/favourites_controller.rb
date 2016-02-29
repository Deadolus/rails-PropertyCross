require 'nestoria'

class FavouritesController < ApplicationController
    layout 'application_no_title', only: [:show]
    before_action :initialize_favourites

    def index
        @propertylistings = session[:favourites]
        unless @propertylistings.nil? || @propertylistings.empty? then
            #flash[:alert] ="No favourites yet - try adding a house!"
            #redirect_to root_path
            #return
        @propertylistings.map! { |l| PropertyListing.new l.symbolize_keys }
        end
    end

    def show
        unless session[:favourites][params[:id].to_i].nil?
            @house = PropertyListing.new session[:favourites][params[:id].to_i]
            if @house.nil?
                flash[:alert] ="Could not find favourite"
                redirect_to root_path
                return
            end
        else
            flash[:alert] = "Invalid favourite"
            redirect_to root_path
            return
        end
    end

    def create
        @favourites.create_favourite params[:favourite]
        respond_to do |format|
            format.html { redirect_to :back rescue redirect_to root_url }
            format.js
        end
    end

    def destroy
        if @favourites.delete_favourite_with_id(params[:id]) || @favourites.delete_favourite_with_title(params[:favourite]["title"])
            respond_to do |format|
                format.html { 
                    flash[:notice] = "Successfully deleted the favourite"
                    redirect_to favourites_path 
                }
                format.js
            end
        else
            respond_to do |format|
                format.html { flash[:alert] = "Could not delete this favourite"; redirect_to :back }
                format.js
            end
        end
    end

    private
    def initialize_favourites
        @favourites = Favourite.new(session)
    end

end
