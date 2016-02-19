require 'assets/nestoria/lib/nestoria/api.rb'

#See http://stackoverflow.com/questions/2680523/dry-ruby-initialization-with-hash-argument
#This is a general class initializer
#class Struct
#    def self.hash_initialized *params
#        klass = Class.new(self.new(*params))
#
#        klass.class_eval do
#            include ActiveModel::Conversion
#            define_method(:initialize) do |h|
#                super(*h.values_at(*params))
#            end
#        end
#        klass
#    end
#end
#
#PropertyListing = Struct.hash_initialized :price, :title, :img_url, :thumb_url,  :bedroom_number, :bathroom_number, :summary

class PropertyListing
            include ActiveModel::Conversion
    attr_accessor :title, :img_url, :thumb_url, :summary
    attr_reader :price, :bedroom_number, :bathroom_number

    def initialize args
        args.each do |k,v|
            instance_variable_set("@#{k}", v) unless v.nil?
        end
        #These variables have to be set separately, doesn't work with instance_variable_set
        @price = args[:price]
        @bedroom_number = args[:bedroom_number]
        @bathroom_number = args[:bathroom_number]
    end

    def price=(str)
        @price = str.to_i
    end
    def bedroom_number=(str)
        @bedroom_number = str.to_i
    end
    def bathroom_number=(str)
        @bathroom_number = str.to_i
    end
end

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
