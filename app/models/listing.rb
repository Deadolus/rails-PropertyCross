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
        @@nestoria ||= MyNestoria.new
        if(location && !location.blank?) then
            listings = []
            total_number = 0
            page.to_i.times do |p|
                l, total_number = @@nestoria.search_place(location, p+1)
                l.each do |listing|
                    listings << PropertyListing.new(listing)
                end
            end
            return listings, total_number
        else
            return listings, total_number
        end
    end
    def self.get_properties(location, page=1)
        self.get_properties_with_total_number(location, page).first
    end

    def self.get_house(location, id)
        return self.get_house_with_total_number(location, id).first
    end
    def self.get_house_with_total_number(location, id)
        listing = self.get_properties_with_total_number(location, id/20+1)
        return listing.first[id], listing.second
    end

    def self.get_location_with_total_number(lat, lon, page=1)
        @@nestoria ||= MyNestoria.new
        if !lat.blank? && !lon.blank? && lat.to_f && lon.to_f then
            listings = []
            total_number = 0
            page.to_i.times do |p|
                l, total_number = @@nestoria.search_location(lat, lon, p+1)
                l.each do |listing|
                    listings << PropertyListing.new(listing)
                end
            end
            return listings, total_number
        else
            return listings, total_number
        end
    end

    def self.get_location(lat, lon, page=1)
        self.get_location_with_total_number(lat,lon, page).first
    end
    def self.get_location_house_with_total_number(lat, lon, id)
        listing = self.get_location_with_total_number(lat, lon, id/20+1)
        return listing.first[id], listing.second
    end
    def self.get_location_house(lat, lon, id)
        return self.get_location_house_with_total_number(lat, lon, id).first
    end

    def self.get_total_number(location, page=1)
        @@nestoria ||= MyNestoria.new
        if location && page>=1 then
            listings, total_number = @@nestoria.search_place(location, page)
            return total_number
        end
    end
end
