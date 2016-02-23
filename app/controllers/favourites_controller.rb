require 'nestoria'

class FavouritesController < ApplicationController
    layout 'application_no_title', only: [:show]
    def index
        @propertylistings = session[:favourites]
        if @propertylistings.nil? || @propertylistings.empty? then
            flash[:alert] ="No favourites yet - try adding a house!"
            redirect_to root_path
            return
        end
        @propertylistings.map! { |l| PropertyListing.new l.symbolize_keys }
    end

    def show
        @house = PropertyListing.new session[:favourites][params[:id].to_i]
        if @house.nil?
            flash[:alert] ="Could not find favourite"
            redirect_to root_path
            return
        end

    end

    def create
        (session[:favourites] ||= []) << params[:favourite]
        redirect_to :back rescue redirect_to root_url
    end

    def destroy
        if params[:id].to_i < session[:favourites].count then
        session[:favourites].delete_at(params[:id].to_i)
        else
            flash[:alert] = "Could not delete this favourite"
        end
        redirect_to favourites_path

    end
end
