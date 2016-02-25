require 'test_helper'

class SearchForLocationTest < ActionDispatch::IntegrationTest
    test "Should be able to search for property" do
        get root_path
        assert_select '#recent-search', count: 0
        get new_listing_path
        assert_response :success
        assert_select '#recent-search', count: 0
        post listings_path,  search: { "location" => "london"}
        assert_redirected_to listing_path "london"
        follow_redirect!
        assert_match /20 of .* matches/, response.body
        assert_select '.property', count: 20
        get root_path
        assert_select '.recent-search', count: 1
        assert_match "London", response.body
        post listings_path, search: { location: "Essex" }
        follow_redirect!
        get root_path
        assert_select '.recent-search', count: 2
        assert_match "Essex", response.body
        post listings_path, search: { location: "Edinburgh" }
        follow_redirect!
        post listings_path, search: { location: "Salem" }
        follow_redirect!
        get root_path
        assert_match "Edinburgh", response.body
        assert_match "Salem", response.body
        assert_select '.recent-search', count: 4
        #Only four searches, London should fall out of list
        post listings_path, search: { location: "Leeds" }
        follow_redirect!
        get root_path
        assert_match "Leeds", response.body
        assert_no_match "London", response.body
        assert_select '.recent-search', count: 4
        #Multiple searches should only appear once
        post listings_path, search: { location: "Leeds" }
        follow_redirect!
        get root_path
        assert_select "a[href=?]", listing_path("leeds"), count: 1
        #Also no case
        post listings_path, search: { location: "LeEdS" }
        follow_redirect!
        get root_path
        assert_select "a[href=?]", listing_path("leeds"), count: 1
    end

    #This test is a bit brittle, if the listing changes between the controller GET and the Listing GET it may fail
    test "all properties should be shown" do
        post listings_path,  search: { "location" => "London"}
        follow_redirect!
        Listing.get_properties("London").each do |house|
            assert_match CGI::escapeHTML(house.title), response.body
        end
    end

    test "the results page should show how man properties there are" do
        post listings_path,  search: { "location" => "london"}
        follow_redirect!
        assert_match Listing.get_total_number("London").to_s, response.body
    end

end