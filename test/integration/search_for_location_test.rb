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
        assert_select '.load-more', count: 1
    end
    test "Searches will be appended to recent searches" do
        search_for_properties("London")
        get root_path
        assert_select '.recent-search', count: 1
        assert_match "London", response.body
        search_for_properties("Essex")
        get root_path
        assert_select '.recent-search', count: 2
        assert_match "Essex", response.body
        search_for_properties("Edinburgh")
        search_for_properties("Salem")
        get root_path
        assert_match "Edinburgh", response.body
        assert_match "Salem", response.body
        assert_select '.recent-search', count: 4
        #Only four searches, London should fall out of list
        search_for_properties("Leeds")
        get root_path
        assert_match "Leeds", response.body
        assert_no_match "London", response.body
        assert_select '.recent-search', count: 4
        #Multiple searches should only appear once
        search_for_properties("Leeds")
        get root_path
        assert_select "tr[data-url=?]", listing_path("Leeds"), count: 1
        #Also no case
        search_for_properties("LeEdS")
        get root_path
        assert_select "tr[data-url=?]", listing_path("Leeds"), count: 1
    end

    #This test is a bit brittle, if the listing changes between the controller GET and the Listing GET it may fail
    test "all properties should be shown" do
        search_for_properties("London")
        Listing.get_properties("London").each do |house|
            assert_match CGI::escapeHTML(house.title), response.body
        end
    end

    test "the results page should show how man properties there are" do
        search_for_properties("London")
        assert_match Listing.get_total_number("London").to_s, response.body
    end

    test "the home page should show how many properties there are after search" do
        search_for_properties("london")
        get root_path
        assert_match Listing.get_total_number("London").to_s, response.body
    end

    test "Should display no properties found when no properties found" do
        post listings_path,  search: { "location" => "testxxx" }
        #First redirect is to listings/testxxx
        follow_redirect!
        #listings show should now redirect to root_path
        assert_redirected_to root_path
        follow_redirect!
        assert_not flash.empty?
        assert_match  "There were no properties found for the given location", flash["alert"]
    end

    test "Older searches with other results number should be removed" do
        search_for_properties("London")
        get root_path
        assert_match "London", response.body
        assert_equal 1, session[:recentsearches].count
        #Simulate an older search with different results number
        session[:recentsearches][0]["results"] = 1
        search_for_properties("London")
        assert_not_equal 0, session[:recentsearches][0]["results"]
    end

    test "My location with empty results gets redirect to root_path" do
        post listings_path,  search: { "location_based" => "true" }
        #First redirect is to listings/testxxx
        follow_redirect!
        #listings show should now redirect to root_path
        assert_redirected_to root_path
        follow_redirect!
        assert_not flash.empty?
        assert_match  "There were no properties found", flash["alert"]
    end

    #FIXME - no use test so far
    test "Should be able to search via my location" do
        post listings_path,  search: { "location_based" => "true" }
        #First redirect is to listings/testxxx
        follow_redirect!
        #listings show should now redirect to root_path
        assert_redirected_to root_path
        follow_redirect!
        assert_not flash.empty?
        assert_match  "There were no properties found", flash["alert"]
    end
    test "redirect on empty search" do
        post listings_path,  search: { "location" => "" }
        #listings show should now redirect to root_path
        assert_redirected_to root_path
        follow_redirect!
        assert_not flash.empty?
        assert_match  "The location given was not recognised", flash["alert"]
    end
end
