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
        unless session[:favourites].nil? || session[:favourites][params[:id].to_i].nil?
            @house = PropertyListing.new session[:favourites][params[:id].to_i]
            #if @house.nil?
            #    flash[:alert] ="There was a problem showing your favourite"
            #    redirect_to root_path
            #    return
            #end
        else
            flash[:alert] = "Invalid favourite"
            redirect_to root_path
            return
        end
    end

    def create
        if @favourites.create_favourite params[:favourite]
        respond_to do |format|
            format.html { redirect_to :back rescue redirect_to root_url }
            format.js
        end
        else
        respond_to do |format|
            @message = "Favourites limited to four entries for now, sorry"
            format.html { 
                flash[:notice] = @message
                redirect_to :back rescue redirect_to root_url 
            }
            format.js { render :partial => "shared/add_notice", locals: { :message => @message } }
        end
        end

    end

    def destroy
        if @favourites.delete_favourite_with_id(params[:id]) || !params[:favourite].nil? && @favourites.delete_favourite_with_title(params[:favourite]["title"])
            respond_to do |format|
                format.html { 
                    flash[:notice] = "Successfully deleted the favourite"
                    redirect_to favourites_path 
                }
                format.js
            end
        else
            message = "Could not delete this favourite"
            respond_to do |format|
                format.html { flash[:alert] = message; redirect_to :back rescue redirect_to root_url }
                format.js { render :partial => 'shared/add_danger', :locals => {:message => message } }
            end
        end
    end

    private
    def initialize_favourites
        @favourites = Favourite.new(session)
    end

end
