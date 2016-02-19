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
        listings = Listing.get_properties()
        assert_equal 0, listings.count
    end
end
