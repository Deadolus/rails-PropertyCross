require 'test_helper'

class ListingTest < ActiveSupport::TestCase
    def setup
  #      @listing = Listing.new
    end
    test "will properly get properties" do
        listings = Listing.get_properties("London")
        assert_equal 20, listings.count
        assert_equal PropertyListing, listings.first.class
        listings = Listing.get_properties("testingstring")
        assert_equal 0, listings.count
    end

    test "testing persisted?" do
        l = Listing.new
        assert_not l.persisted?
    end

    test "get location - no valid location" do
        listings, number = Listing.get_properties_with_total_number("")
        assert listings.nil?
        assert number.nil?
    end
    test "get lat/lon - no valid lat/lon" do
        listings, number = Listing.get_location_with_total_number("", "")
        assert listings.nil?
        assert number.nil?
    end

    test "get house" do
        house = Listing.get_house("London", 10)
        listing = Listing.get_properties("London")
        assert_equal house.title, listing[10].title
    end
    test "get house with total_number" do
        house, number = Listing.get_house_with_total_number("London", 10)
        listing, listing_number = Listing.get_properties_with_total_number("London")
        assert_equal house.title, listing[10].title
        assert_equal number, listing_number
    end

    test "get location with total_number" do
        listings, number = Listing.get_location_with_total_number("51.5","-0.12", )
        assert_equal 20, listings.count
        assert_operator 20, :<, number
    end
    test "get location" do
        listings = Listing.get_location("51.5","-0.12" )
        assert_equal 20, listings.count
    end
    test "get loation house" do
        house = Listing.get_location_house("51.5","-0.12", 10)
        listing = Listing.get_location("51.5","-0.12")
        assert_equal house.title, listing[10].title
    end
    test "get location house with total_number" do
        house, number = Listing.get_location_house_with_total_number("51.5", "-0.12", 10)
        listing, listing_number = Listing.get_location_with_total_number("51.5", "-0.12")
        assert_equal house.title, listing[10].title
        assert_equal number, listing_number
    end
    test "get location total number" do
        number = Listing.get_total_number("London")
        listing, listing_number = Listing.get_properties_with_total_number("London")
        assert_equal number, listing_number
    end


end
