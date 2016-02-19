require 'assets/nestoria/lib/nestoria/api.rb'

#See http://stackoverflow.com/questions/2680523/dry-ruby-initialization-with-hash-argument
#This is a general class initializer
class Struct
    def self.hash_initialized *params
        klass = Class.new(self.new(*params))

        klass.class_eval do
            include ActiveModel::Conversion
            define_method(:initialize) do |h|
                super(*h.values_at(*params))
            end
        end
        klass
    end
end

PropertyListing = Struct.hash_initialized :price, :title, :img_url, :thumb_url,  :bedroom_number, :bathroom_number, :summary

class MyNestoria
    def initialize
        @@nestoria = Nestoria::Api.new(:uk)
    end

    def search_place(place, page = 1)
        get_listings(place, page)
    end

    private
    def get_listings(place, page=1)
        response = @@nestoria.search :listing_type => "buy", :place_name => place, :page => page
        if listings = response["listings"] then
            listings.each do |listing|
                listing.symbolize_keys!
            end
            return listings
        else
            return {}
        end
    end

end
