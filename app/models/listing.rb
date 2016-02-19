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
    #def persisted?
    #    false
    #end

    #Gets properties from nestoria
    def Listing.get_properties(location=@location, page=1)
        @listings = []
        if(location) then
            nestoria = MyNestoria.new
            listings = nestoria.search_place(location, page)
            listings.each do |listing|
                @listings << PropertyListing.new(listing)
            end
            return @listings
        else
            return @listings
        end
    end
end
