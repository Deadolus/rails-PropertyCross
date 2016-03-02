require 'test_helper'
require 'nestoria'

class AddingFavouritesTest < ActionDispatch::IntegrationTest
    def setup
        #@house = PropertyListing.new :title => "Test", :price => "666" 
        @house = {title:  "Test", price: "666", thumb_url: "test_thumb_url", img_url: "test_img_url", bathroom_number: 123, bedroom_number: 456, summary: "Test summary"}
    end
    test "favourites should be empty at first" do
        #Empty at first
        get favourites_path
        assert_match "You have not added any properties", response.body
    end

    test "should be able to add favourite" do
        post favourites_path, favourite: @house #{ title: "Test", price: "666" }
        get favourites_path
        assert_match @house[:title], response.body
        assert_match @house[:thumb_url], response.body
        get favourite_path(0)
        assert_match @house[:title], response.body
        assert_match @house[:img_url], response.body
        assert_match @house[:summary], response.body
        assert_match @house[:price], response.body
        assert_match @house[:bedroom_number].to_s, response.body
        assert_match @house[:bathroom_number].to_s, response.body
    end
    test "should be able to add favourite with Ajax" do
        xhr :post, favourites_path, favourite: @house #{ title: "Test", price: "666" }
        get favourites_path
        assert_match @house[:title], response.body
        assert_match @house[:thumb_url], response.body
    end
    test "redirect on empty favourite" do
        get favourite_path(0)
        assert_redirected_to root_path
        follow_redirect!
        assert_not flash.empty?
        assert_match "Invalid favourite", response.body
    end
    #This test is probably not needed, as there shouldn't be any invalid houses being generated in the controller
    #test "Invalid house in favourites" do
    #    @house.delete :title
    #    @house.delete :thumb_url
    #    post @house
    #    get_favourite_path(0)
    #    assert_redirected_to root_path
    #    follow_redirect!
    #    assert_not flash.empty?
    #    assert_match "There was a problem showing your favourite", response.body
    #end
end
