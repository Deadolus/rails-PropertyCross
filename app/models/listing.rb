# == Schema Information
#
# Table name: listings
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  updated_at :datetime         not null
#

require 'nestoria'
#< ActiveRecord::Base
class Listing
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    #attr_reader :listings
    #attr_accessor :location

    #validates :location, presence: true

    #Initialize attributes
    #def initialize(attributes = {})
    #    attributes.each do |name, value|
    #        send("#{name}=", value)
    #    end
    #end

    #from tutorial, maybe not needed?
    def persisted?
        false
    end
    def initialize
        @@nestoria ||= MyNestoria.new
    end

    #Gets properties from nestoria
    def self.get_properties_with_total_number(location, page=1)
        @listings = []
        @@nestoria ||= MyNestoria.new
        if(location) then
            listings, total_number = @@nestoria.search_place(location, page)
            listings.each do |listing|
                @listings << PropertyListing.new(listing)
            end
            return @listings, total_number
        else
            return @listings, total_number
        end
    end
    def self.get_properties(location, page=1)
        self.get_properties_with_total_number(location, page).first
    end
    def self.get_location_with_total_number(lat, lon, page=1)
        @listings = []
        @@nestoria ||= MyNestoria.new
        if lat.to_f && lon.to_f then
            listings, total_number = @@nestoria.search_location(lat, lon, page)
            listings.each do |listing|
                @listings << PropertyListing.new(listing)
            end
            return @listings, total_number
        else
            return @listings, total_number
        end
    end

    def self.get_location(lat, lon, page=1)
        self.get_location_with_total_number(lat,lon, page).first
    end

    def self.get_total_number(location, page=1)
        @@nestoria ||= MyNestoria.new
        if location && page>=1 then
            listings, total_number = @@nestoria.search_place(location, page)
            return total_number
        end
    end
end